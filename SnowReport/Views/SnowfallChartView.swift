import SwiftUI
import Charts

struct SnowfallChartView: View {
  @StateObject private var viewModel: SnowfallChartViewModel
  
  init(snowReports: [SnowReport], hourlyWeather: [HourlyWeather]) {
    _viewModel = StateObject(wrappedValue: SnowfallChartViewModel(
      snowReports: snowReports,
      hourlyWeather: hourlyWeather
    ))
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text(Strings.Charts.snowfall)
        .font(.title2)
        .bold()
        .padding(.horizontal)
      
      if viewModel.hasSnowfall {
        Chart {
          ForEach(viewModel.recentSnowfall) { hourly in
            BarMark(
              x: .value("Time", hourly.date, unit: .hour),
              y: .value("Snowfall", hourly.snowfall)
            )
            .foregroundStyle(Color.blue)
            .cornerRadius(8)
          }
        }
        .frame(height: 200)
        .padding()
        .chartXAxis {
          AxisMarks(values: .stride(by: .hour, count: 6)) { value in
            if let date = value.as(Date.self) {
              AxisValueLabel {
                Text(date, format: .dateTime.hour().locale(Locale(identifier: "en_US")))
                  .font(.footnote)
              }
            }
          }
        }
        .chartYAxis {
          AxisMarks { value in
            AxisValueLabel("\(value.index)cm")
          }
        }
      } else {
        VStack(spacing: 12) {
          Image(systemName: "snow")
            .font(.system(size: 40))
            .foregroundStyle(Color.blue)
          Text(Strings.Charts.noSnowfall)
            .foregroundStyle(.secondary)
        }
        .frame(height: 200)
        .frame(maxWidth: .infinity)
        .padding()
      }
    }
    .padding(.vertical)
    .background(Color(.systemBackground))
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .shadow(radius: 2)
    .padding(.horizontal)
  }
}

#Preview {
  SnowfallChartView(snowReports: [
    SnowReport(
      date: Date(),
      snowfall: 10,
      temperature: -5,
      conditions: "Snow",
      windspeed: 15
    ),
    SnowReport(
      date: Date().addingTimeInterval(86400),
      snowfall: 5,
      temperature: -2,
      conditions: "Clear",
      windspeed: 10
    )
  ], hourlyWeather: [
    HourlyWeather(date: Date(), temperature: 10, snowfall: 2, windspeed: 15),
    HourlyWeather(date: Date().addingTimeInterval(3600), temperature: 12, snowfall: 0, windspeed: 12),
    HourlyWeather(date: Date().addingTimeInterval(7200), temperature: 14, snowfall: 0, windspeed: 10),
    HourlyWeather(date: Date().addingTimeInterval(10800), temperature: 16, snowfall: 1, windspeed: 8),
    HourlyWeather(date: Date().addingTimeInterval(14400), temperature: 18, snowfall: 0, windspeed: 11),
    HourlyWeather(date: Date().addingTimeInterval(18000), temperature: 20, snowfall: 0, windspeed: 13),
    HourlyWeather(date: Date().addingTimeInterval(21600), temperature: 22, snowfall: 0, windspeed: 14),
    HourlyWeather(date: Date().addingTimeInterval(25200), temperature: 24, snowfall: 0, windspeed: 16),
    HourlyWeather(date: Date().addingTimeInterval(28800), temperature: 26, snowfall: 0, windspeed: 15),
    HourlyWeather(date: Date().addingTimeInterval(32400), temperature: 28, snowfall: 0, windspeed: 12)
  ])
}
