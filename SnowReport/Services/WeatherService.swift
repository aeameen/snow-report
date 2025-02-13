import Foundation

enum WeatherServiceError: Error {
  case invalidURL
  case invalidResponse
  case networkError(Error)
  case decodingError(Error)
}

actor WeatherService {
  private let session: URLSession
  
  init(session: URLSession = .shared) {
    self.session = session
  }
  
  func fetchSnowData(latitude: Double, longitude: Double) async throws -> [SnowReport] {
    async let historicalData = fetchTimelineData(
      latitude: latitude,
      longitude: longitude,
      startTime: "nowMinus24h",
      endTime: "now"
    )
    
    async let forecastData = fetchTimelineData(
      latitude: latitude,
      longitude: longitude,
      startTime: "now",
      endTime: "nowPlus5d"
    )
    
    let (historical, forecast) = try await (historicalData, forecastData)
    return (historical + forecast).sorted { $0.date < $1.date }
  }
  
  private func fetchTimelineData(
    latitude: Double,
    longitude: Double,
    startTime: String,
    endTime: String
  ) async throws -> [SnowReport] {
    let endpoint = "\(WeatherConfig.baseURL)/timelines"
    
    let parameters: [String: Any] = [
      "location": "\(latitude), \(longitude)",
      "fields": WeatherConfig.fields,
      "units": "metric",
      "timesteps": ["1d"],
      "startTime": startTime,
      "endTime": endTime
    ]
    
    // Convert parameters to JSON data
    let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
    
    // Create URL with query parameters
    let url = URL(string: endpoint)!
    var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
    components.queryItems = [
      URLQueryItem(name: "apikey", value: WeatherConfig.apiKey)
    ]
    
    // Create and configure request
    var request = URLRequest(url: components.url!)
    request.httpMethod = "POST"
    request.timeoutInterval = 10
    request.allHTTPHeaderFields = [
      "accept": "application/json",
      "Accept-Encoding": "deflate, gzip, br",
      "content-type": "application/json"
    ]
    request.httpBody = postData
    
    let (data, response) = try await session.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse else {
      throw WeatherServiceError.invalidResponse
    }
    
    // Print response for debugging
    print("Status code: \(httpResponse.statusCode)")
    print("Response data: \(String(data: data, encoding: .utf8) ?? "")")
    
    guard (200...299).contains(httpResponse.statusCode) else {
      throw WeatherServiceError.invalidResponse
    }
    
    do {
      let weatherData = try JSONDecoder().decode(TimelineResponse.self, from: data)
      return processWeatherData(weatherData)
    } catch {
      print("Decoding error: \(error)")
      throw WeatherServiceError.decodingError(error)
    }
  }
  
  private func processWeatherData(_ response: TimelineResponse) -> [SnowReport] {
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withInternetDateTime]
    
    return response.data.timelines[0].intervals.map { interval in
      let values = interval.values
      return SnowReport(
        date: dateFormatter.date(from: interval.startTime) ?? Date(),
        snowfall: values.snowAccumulation ?? 0.0,
        temperature: values.temperature,
        conditions: getWeatherDescription(code: values.getWeatherCode())
      )
    }
  }
  
  private func getWeatherDescription(code: Int) -> String {
    // Tomorrow.io weather codes mapping
    switch code {
    case 1000: return "Clear"
    case 1100: return "Mostly Clear"
    case 1101: return "Partly Cloudy"
    case 1102: return "Mostly Cloudy"
    case 1001: return "Cloudy"
    case 4000: return "Light Rain"
    case 4001: return "Rain"
    case 4200: return "Light Snow"
    case 4201: return "Snow"
    case 4202: return "Heavy Snow"
    default: return "Unknown"
    }
  }
}
