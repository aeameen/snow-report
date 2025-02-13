import SwiftUI

struct CurrentConditionsView: View {
  let report: SnowReport
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      VStack(alignment: .leading, spacing: 16) {
        Text(Strings.CurrentConditions.title)
          .font(.title2)
          .bold()
          .padding(.horizontal)
        
        VStack(spacing: 24) {
          // First row: Temperature and Snow
          HStack(alignment: .center, spacing: 24) {
            // Temperature
            VStack(spacing: 8) {
              Image(systemName: Icons.Weather.temperature)
                .foregroundStyle(Color.blue)
                .font(.system(size: 28))
                .frame(height: 32)
              Text("\(Int(report.temperature))°C")
                .font(.system(size: 24, weight: .bold))
                .frame(height: 28)
              Text(Strings.CurrentConditions.current)
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            
            // Snow
            VStack(spacing: 8) {
              Image(systemName: Icons.Weather.snowfall)
                .font(.system(size: 28))
                .foregroundStyle(.blue.opacity(0.8))
                .frame(height: 32)
              Text("\(Int(report.snowfall))cm")
                .font(.system(size: 24, weight: .bold))
                .frame(height: 28)
              Text(Strings.CurrentConditions.freshSnow)
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
          }
          
          // Second row: Wind and Conditions
          HStack(alignment: .center, spacing: 24) {
            // Wind
            VStack(spacing: 8) {
              Image(systemName: Icons.Weather.wind)
                .font(.system(size: 28))
                .foregroundStyle(.blue.opacity(0.8))
                .frame(height: 32)
              Text("\(Int(report.windspeed))km/h")
                .font(.system(size: 24, weight: .bold))
                .frame(height: 28)
              Text(Strings.CurrentConditions.wind)
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
              Text(Strings.CurrentConditions.conditions)
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
          }
        }
        .padding()
      }
      .padding(.vertical)
      .background(Color(.systemBackground))
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .shadow(radius: 2)
      .padding(.horizontal)
    }
  }
  
  private func getWeatherSymbol(for conditions: String) -> String {
    switch conditions.lowercased() {
    case let s where s.contains("clear"): return Icons.Weather.clear
    case let s where s.contains("cloudy"): return Icons.Weather.cloudy
    case let s where s.contains("snow"): return Icons.Weather.snow
    case let s where s.contains("rain"): return Icons.Weather.rain
    default: return Icons.Weather.cloudy
    }
  }
}

#Preview {
  CurrentConditionsView(
    report: SnowReport(
      date: Date(),
      snowfall: 15,
      temperature: -5,
      conditions: "Snow",
      windspeed: 10
    )
  )
}
