import Foundation

struct Resort: Codable, Identifiable {
  let id: String
  let name: String
  let location: String
  let latitude: Double
  let longitude: Double
}
