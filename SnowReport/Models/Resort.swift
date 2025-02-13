import Foundation

struct Resort: Codable, Identifiable {
  let id: String
  let name: String
  let location: String
  let latitude: Double
  let longitude: Double
  
  // For location suggestions
  var searchText: String {
    name.lowercased()
  }
}

struct SnowReport: Codable {
  let date: Date
  let snowfall: Double
  let temperature: Double
  let conditions: String
}