import Foundation

@MainActor
class RecentSnowfallViewModel: ObservableObject {
  @Published private(set) var overnight: Double = 0
  @Published private(set) var last24h: Double = 0
  @Published private(set) var last2days: Double = 0
  @Published private(set) var lastWeek: Double = 0
  
  func calculateSnowfall(from hourlyWeather: [HourlyWeather]) {
    let calendar = Calendar.current
    let now = Date()
    
    // Round current time to nearest hour
    let nearestHour = calendar.date(
      bySetting: .minute,
      value: 30,
      of: now
    ).map { date in
      calendar.date(
        byAdding: .minute,
        value: 30,
        to: date
      )!
    } ?? now
    
    // Get 4 PM today for overnight calculation
    var components = calendar.dateComponents([.year, .month, .day], from: now)
    components.hour = 16 // 4 PM
    let todayClose = calendar.date(from: components) ?? now
    let yesterdayClose = calendar.date(byAdding: .day, value: -1, to: todayClose) ?? now
    
    // Calculate overnight (4 PM yesterday to now)
    overnight = hourlyWeather
      .filter { $0.date >= yesterdayClose && $0.date <= now }
      .reduce(0) { $0 + $1.snowfall }
    
    // Calculate last 24 hours from current time
    last24h = hourlyWeather
      .filter { $0.date >= calendar.date(byAdding: .hour, value: -24, to: nearestHour)! }
      .reduce(0) { $0 + $1.snowfall }
    
    // Calculate last 2 days (additional snowfall beyond last 24h)
    let last48hSnowfall = hourlyWeather
      .filter { $0.date >= calendar.date(byAdding: .hour, value: -48, to: nearestHour)! }
      .reduce(0) { $0 + $1.snowfall }
    last2days = last48hSnowfall
    
    // Calculate last week (additional snowfall beyond last 2 days)
    let weekSnowfall = hourlyWeather
      .filter { $0.date >= calendar.date(byAdding: .day, value: -7, to: nearestHour)! }
      .reduce(0) { $0 + $1.snowfall }
    lastWeek = weekSnowfall
  }
}
