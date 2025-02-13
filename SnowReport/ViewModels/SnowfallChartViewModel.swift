import Foundation

@MainActor
class SnowfallChartViewModel: ObservableObject {
    let snowReports: [SnowReport]
    let hourlyWeather: [HourlyWeather]
    
    init(snowReports: [SnowReport], hourlyWeather: [HourlyWeather]) {
        self.snowReports = snowReports
        self.hourlyWeather = hourlyWeather
    }
    
    var recentSnowfall: [HourlyWeather] {
        let calendar = Calendar.current
        let now = Date()
        
        // Get 4 PM today
        var components = calendar.dateComponents([.year, .month, .day], from: now)
        components.hour = 16 // 4 PM
        let todayClose = calendar.date(from: components) ?? now
        
        // Get 4 PM yesterday
        let yesterdayClose = calendar.date(byAdding: .day, value: -1, to: todayClose) ?? now
        
        return hourlyWeather.filter { hourly in
            hourly.date >= yesterdayClose && hourly.date <= todayClose
        }.sorted { $0.date < $1.date }
    }
    
    var hasSnowfall: Bool {
        recentSnowfall.contains { $0.snowfall > 0 }
    }
} 