import Foundation

struct TimelineResponse: Codable {
  let data: TimelineData
}

struct TimelineData: Codable {
  let timelines: [Timeline]
}

struct Timeline: Codable {
  let timestep: String
  let endTime: String
  let startTime: String
  let intervals: [Interval]
}

struct Interval: Codable {
  let startTime: String
  let values: WeatherValues
}