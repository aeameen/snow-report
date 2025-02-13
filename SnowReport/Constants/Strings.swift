import Foundation

enum Strings {
  enum Home {
    static let attribution = "Weather data provided by Open-Meteo.com"
    static let loading = "Loading snow report..."
  }
  
  enum CurrentConditions {
    static let title = "Current Conditions"
    static let current = "Current"
    static let freshSnow = "New Snow"
    static let conditions = "Weather"
    static let wind = "Wind"
  }
  
  enum RecentSnowfall {
    static let title = "Recent Snowfall"
    static let overnight = "Overnight"
    static let last24h = "Last 24h"
    static let last2Days = "Last 2 Days"
    static let lastWeek = "Last Week"
  }
  
  enum Charts {
    static let temperature = "Today's Temperature"
    static let snowfall = "Today's Snowfall"
    static let noSnowfall = "No snowfall today"
  }
  
  enum Weather {
    static let clear = "Clear"
    static let partlyCloudy = "Partly Cloudy"
    static let foggy = "Foggy"
    static let lightRain = "Light Rain"
    static let rain = "Rain"
    static let snow = "Snow"
    static let snowGrains = "Snow Grains"
    static let heavySnow = "Heavy Snow"
    static let thunderstorm = "Thunderstorm"
    static let thunderstormWithHail = "Thunderstorm with Hail"
    static let unknown = "Unknown"
  }
  
  enum Error {
    static let invalidURL = "Invalid URL configuration"
    static let serverError = "Server error occurred"
    static let dataProcessing = "Error processing weather data"
    static let invalidResponse = "Invalid response from server"
    static let unknown = "An unknown error occurred"
  }
  
  enum Search {
    static let title = "BC Ski Resorts"
    static let searchPrompt = "Search resorts"
    static let cancel = "Cancel"
  }
} 
