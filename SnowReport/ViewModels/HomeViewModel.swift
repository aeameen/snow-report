import Foundation

@MainActor
class HomeViewModel: ObservableObject {
  @Published private(set) var resort: Resort
  @Published private(set) var snowReports: [SnowReport] = []
  @Published private(set) var hourlyTemperatures: [HourlyWeather] = []
  @Published private(set) var isInitialLoad = true
  @Published private(set) var isLoading = false
  @Published private(set) var error: OpenMeteoError?
  
  private let service = OpenMeteoService()
  private var fetchTask: Task<Void, Never>?
  
  init(resort: Resort = ResortConfig.whitewater) {
    self.resort = resort
    fetchTask = Task {
      await fetchWeatherData(isInitialLoad: true)
    }
  }
  
  deinit {
    fetchTask?.cancel()
  }
  
  func updateResort(_ newResort: Resort) {
    guard newResort.id != resort.id else { return }
    resort = newResort
    Task {
      await fetchWeatherData(isInitialLoad: true)
    }
  }
  
  func fetchWeatherData(isInitialLoad: Bool = false) async {
    fetchTask?.cancel()
    
    fetchTask = Task {
      if isInitialLoad {
        self.isLoading = true
      }
      
      error = nil
      
      do {
        let (reports, hourly) = try await service.fetchWeatherData(
          latitude: resort.latitude,
          longitude: resort.longitude
        )
        
        if !Task.isCancelled {
          self.snowReports = reports
          self.hourlyTemperatures = hourly
        }
      } catch let error as OpenMeteoError {
        if !Task.isCancelled {
          self.error = error
        }
      } catch {
        if !Task.isCancelled {
          if (error as NSError).domain == NSURLErrorDomain {
            self.error = .serverError
          } else {
            self.error = .dataProcessingError
          }
        }
      }
      
      if !Task.isCancelled {
        if isInitialLoad {
          self.isInitialLoad = false
        }
        self.isLoading = false
      }
    }
  }
}
