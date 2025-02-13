import Foundation

struct SnowReport: Codable {
    let date: Date
    let snowfall: Double
    let temperature: Double
    let conditions: String
    let windspeed: Double
} 