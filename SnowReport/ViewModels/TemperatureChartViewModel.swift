import Foundation

@MainActor
class TemperatureChartViewModel: ObservableObject {
    let hourlyWeather: [HourlyWeather]
    @Published var selectedHour: HourlyWeather?
    
    init(hourlyWeather: [HourlyWeather]) {
        self.hourlyWeather = hourlyWeather
    }
    
    var todayTemperatures: [HourlyWeather] {
        let calendar = Calendar.current
        let today = Date()
        
        return hourlyWeather.filter { weather in
            calendar.isDate(weather.date, inSameDayAs: today)
        }.sorted { $0.date < $1.date }
    }
    
    var temperatureRange: (min: Double, max: Double) {
        guard let min = todayTemperatures.map({ $0.temperature }).min(),
              let max = todayTemperatures.map({ $0.temperature }).max() else {
            return (0, 0)
        }
        // Add some padding to the range
        return (min - 1, max + 1)
    }
} 