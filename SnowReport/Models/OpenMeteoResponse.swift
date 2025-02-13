import Foundation

struct OpenMeteoResponse: Codable {
  let latitude: Double
  let longitude: Double
  let timezone: String
  let daily: DailyData
  let hourly: HourlyData
  let daily_units: DailyUnits
  let hourly_units: HourlyUnits
}

struct DailyUnits: Codable {
  let time: String
  let temperature_2m_max: String
  let temperature_2m_min: String
  let snowfall_sum: String
  let weathercode: String
}

struct DailyData: Codable {
  let time: [Date]
  let temperature_2m_max: [Double]
  let temperature_2m_min: [Double]
  let snowfall_sum: [Double]
  let weathercode: [Int]
  
  private enum CodingKeys: String, CodingKey {
    case time
    case temperature_2m_max
    case temperature_2m_min
    case snowfall_sum
    case weathercode
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    let dateStrings = try container.decode([String].self, forKey: .time)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    self.time = dateStrings.compactMap { dateFormatter.date(from: $0) }
    self.temperature_2m_max = try container.decode([Double].self, forKey: .temperature_2m_max)
    self.temperature_2m_min = try container.decode([Double].self, forKey: .temperature_2m_min)
    self.snowfall_sum = try container.decode([Double].self, forKey: .snowfall_sum)
    self.weathercode = try container.decode([Int].self, forKey: .weathercode)
  }
}

struct HourlyData: Codable {
  let time: [Date]
  let temperature_2m: [Double]
  let snowfall: [Double]
  let windspeed_10m: [Double]
  
  private enum CodingKeys: String, CodingKey {
    case time
    case temperature_2m
    case snowfall
    case windspeed_10m
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    let dateStrings = try container.decode([String].self, forKey: .time)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
    
    self.time = dateStrings.compactMap { dateFormatter.date(from: $0) }
    self.temperature_2m = try container.decode([Double].self, forKey: .temperature_2m)
    self.snowfall = try container.decode([Double].self, forKey: .snowfall)
    self.windspeed_10m = try container.decode([Double].self, forKey: .windspeed_10m)
  }
}

struct HourlyUnits: Codable {
  let temperature_2m: String
  let snowfall: String
  let windspeed_10m: String
}
