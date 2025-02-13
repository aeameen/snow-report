import Foundation

struct WeatherValues: Codable {
  let temperature: Double
  let snowAccumulation: Double?
  let precipitationType: Double?
  let weatherCode: Double?
  
  func getWeatherCode() -> Int {
    Int(weatherCode ?? 1000)
  }
}