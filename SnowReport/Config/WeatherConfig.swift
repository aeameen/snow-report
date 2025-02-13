import Foundation

enum WeatherConfig {
  static let apiKey = "A9yn0Gi3Eg1IJDeN5gv9wI3jw11BTskd"
  static let baseURL = "https://api.tomorrow.io/v4"
  
  static let fields = [
    "temperature",
    "snowAccumulation",
    "precipitationType",
    "weatherCode"
  ]
} 
