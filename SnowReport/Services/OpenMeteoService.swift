import Foundation

enum OpenMeteoError: LocalizedError {
  case invalidURLConfiguration
  case serverError
  case dataProcessingError
  case invalidResponse
  case unknown
  
  var errorDescription: String? {
    switch self {
    case .invalidURLConfiguration:
      return Strings.Error.invalidURL
    case .serverError:
      return Strings.Error.serverError
    case .dataProcessingError:
      return Strings.Error.dataProcessing
    case .invalidResponse:
      return Strings.Error.invalidResponse
    case .unknown:
      return Strings.Error.unknown
    }
  }
}

class OpenMeteoService {
  private let baseURL = "https://api.open-meteo.com/v1/forecast"
  
  func fetchWeatherData(latitude: Double, longitude: Double) async throws -> (reports: [SnowReport], hourly: [HourlyWeather]) {
    let url = "\(baseURL)?latitude=\(latitude)&longitude=\(longitude)&daily=temperature_2m_max,temperature_2m_min,snowfall_sum,weathercode&hourly=temperature_2m,snowfall,windspeed_10m&timezone=America%2FLos_Angeles"
    
    guard let url = URL(string: url) else {
      throw OpenMeteoError.invalidURLConfiguration
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse else {
      throw OpenMeteoError.invalidResponse
    }
    
    guard httpResponse.statusCode == 200 else {
      throw OpenMeteoError.serverError
    }
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    do {
      let response = try decoder.decode(OpenMeteoResponse.self, from: data)
      return processWeatherData(response)
    } catch {
      throw OpenMeteoError.dataProcessingError
    }
  }
  
  private func processWeatherData(_ response: OpenMeteoResponse) -> (reports: [SnowReport], hourly: [HourlyWeather]) {
    // Process daily reports
    var reports: [SnowReport] = []
    for i in 0..<response.daily.time.count {
      let report = SnowReport(
        date: response.daily.time[i],
        snowfall: response.daily.snowfall_sum[i],
        temperature: (response.daily.temperature_2m_max[i] + response.daily.temperature_2m_min[i]) / 2.0,
        conditions: getWeatherDescription(code: response.daily.weathercode[i]),
        windspeed: response.hourly.windspeed_10m[i]
      )
      reports.append(report)
    }
    
    // Process hourly data
    var hourly: [HourlyWeather] = []
    for i in 0..<response.hourly.time.count {
      let weather = HourlyWeather(
        date: response.hourly.time[i],
        temperature: response.hourly.temperature_2m[i],
        snowfall: response.hourly.snowfall[i],
        windspeed: response.hourly.windspeed_10m[i]
      )
      hourly.append(weather)
    }
    
    return (reports, hourly)
  }
  
  private func getWeatherDescription(code: Int) -> String {
    switch code {
    case 0: return Strings.Weather.clear
    case 1, 2, 3: return Strings.Weather.partlyCloudy
    case 45, 48: return Strings.Weather.foggy
    case 51, 53, 55: return Strings.Weather.lightRain
    case 61, 63, 65: return Strings.Weather.rain
    case 71, 73, 75: return Strings.Weather.snow
    case 77: return Strings.Weather.snowGrains
    case 85, 86: return Strings.Weather.heavySnow
    case 95: return Strings.Weather.thunderstorm
    case 96, 99: return Strings.Weather.thunderstormWithHail
    default: return Strings.Weather.unknown
    }
  }
}
