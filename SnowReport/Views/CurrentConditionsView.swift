import SwiftUI

struct CurrentConditionsView: View {
  let report: SnowReport
  
  var body: some View {
    VStack(spacing: 16) {
      HStack(alignment: .center, spacing: 24) {
        // Temperature
        VStack(spacing: 8) {
          Image(systemName: "thermometer")
            .font(.system(size: 28))
            .foregroundColor(.red)
            .frame(height: 32)
          Text("\(Int(report.temperature))°")
            .font(.system(size: 24, weight: .bold))
            .frame(height: 28)
          Text("Current")
            .font(.system(size: 12))
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        
        // Snow
        VStack(spacing: 8) {
          Image(systemName: "snow")
            .font(.system(size: 28))
            .foregroundColor(.blue)
            .frame(height: 32)
          Text("\(Int(report.snowfall))cm")
            .font(.system(size: 24, weight: .bold))
            .frame(height: 28)
          Text("Fresh Snow")
            .font(.system(size: 12))
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        
        // Conditions
        VStack(spacing: 8) {
          Image(systemName: getWeatherSymbol(for: report.conditions))
            .font(.system(size: 28))
            .foregroundColor(.blue)
            .frame(height: 32)
          Text(report.conditions)
            .font(.system(size: 24, weight: .bold))
            .frame(height: 28)
            .minimumScaleFactor(0.5)
            .lineLimit(1)
          Text("Conditions")
            .font(.system(size: 12))
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
      }
      .padding(20)
      .background(Color(.systemBackground))
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .shadow(radius: 2)
      .padding(.horizontal)
    }
  }
  
  private func getWeatherSymbol(for conditions: String) -> String {
    switch conditions.lowercased() {
    case let s where s.contains("clear"): return "sun.max.fill"
    case let s where s.contains("cloudy"): return "cloud.fill"
    case let s where s.contains("snow"): return "cloud.snow.fill"
    case let s where s.contains("rain"): return "cloud.rain.fill"
    default: return "cloud.fill"
    }
  }
}

#Preview {
  CurrentConditionsView(
    report: SnowReport(
      date: Date(),
      snowfall: 15,
      temperature: -5,
      conditions: "Snow"
    )
  )
} 
