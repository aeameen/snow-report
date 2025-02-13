import Foundation

struct HourlyWeather: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    let temperature: Double
    let snowfall: Double
    let windspeed: Double
    
    static func == (lhs: HourlyWeather, rhs: HourlyWeather) -> Bool {
        lhs.date == rhs.date &&
        lhs.temperature == rhs.temperature &&
        lhs.snowfall == rhs.snowfall &&
        lhs.windspeed == rhs.windspeed
    }
} 