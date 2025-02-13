import Foundation
import CoreLocation

enum SnowReportError: LocalizedError {
  case invalidURLConfiguration
  case serverError
  case dataProcessingError
  case unknown(Error)
  
  var errorDescription: String? {
    switch self {
    case .invalidURLConfiguration:
      return "Invalid URL configuration"
    case .serverError:
      return "Invalid response from server"
    case .dataProcessingError:
      return "Error processing weather data"
    case .unknown:
      return "An unexpected error occurred"
    }
  }
}

@MainActor
class SnowReportViewModel: ObservableObject {
  @Published var selectedResort: Resort?
  @Published var snowReports: [SnowReport] = []
  @Published var isLoading = false
  @Published var error: SnowReportError?
  
  private let weatherService = WeatherService()
  private let userDefaults = UserDefaults.standard
  private let locationKey = "selectedResort"
  
  init() {
    loadSavedResort()
  }
  
  func selectResort(_ resort: Resort) {
    selectedResort = resort
    saveResort(resort)
    Task {
      await fetchSnowData()
    }
  }
  
  private func loadSavedResort() {
    if let savedResortData = userDefaults.data(forKey: locationKey),
       let resort = try? JSONDecoder().decode(Resort.self, from: savedResortData) {
      selectedResort = resort
      Task {
        await fetchSnowData()
      }
    }
  }
  
  private func saveResort(_ resort: Resort) {
    if let encoded = try? JSONEncoder().encode(resort) {
      userDefaults.set(encoded, forKey: locationKey)
    }
  }
  
  func fetchSnowData() async {
    guard let resort = selectedResort else { return }
    
    isLoading = true
    error = nil
    
    do {
      snowReports = try await weatherService.fetchSnowData(
        latitude: resort.latitude,
        longitude: resort.longitude
      )
    } catch WeatherServiceError.invalidURL {
      error = .invalidURLConfiguration
    } catch WeatherServiceError.invalidResponse {
      error = .serverError
    } catch WeatherServiceError.decodingError {
      error = .dataProcessingError
    } catch {
      self.error = .unknown(error)
    }
    
    isLoading = false
  }
}
