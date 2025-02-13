import SwiftUI
import Charts

struct TemperatureChartView: View {
  @StateObject private var viewModel: TemperatureChartViewModel
  
  init(hourlyWeather: [HourlyWeather]) {
    _viewModel = StateObject(wrappedValue: TemperatureChartViewModel(
      hourlyWeather: hourlyWeather
    ))
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text(Strings.Charts.temperature)
        .font(.title2)
        .bold()
        .padding(.horizontal)
      
      Chart {
        ForEach(viewModel.todayTemperatures) { weather in
          LineMark(
            x: .value("Time", weather.date, unit: .hour),
            y: .value("Temperature", weather.temperature)
          )
          .foregroundStyle(Color.blue)
          .interpolationMethod(.cardinal)
          .lineStyle(StrokeStyle(lineWidth: 3))
        }
        
        if let selected = viewModel.selectedHour {
          RuleMark(
            x: .value("Time", selected.date)
          )
          .foregroundStyle(Color.gray.opacity(0.3))
          .lineStyle(StrokeStyle(lineWidth: 1))
          
          PointMark(
            x: .value("Time", selected.date),
            y: .value("Temperature", selected.temperature)
          )
          .foregroundStyle(Color.clear)
          .annotation(position: .top) {
            VStack(spacing: 4) {
              Text("\(Int(selected.temperature))°C")
              Text(selected.date, format: .dateTime.hour().locale(Locale(identifier: "en_US")))
            }
            .font(.caption)
            .foregroundColor(.primary)
            .padding(8)
            .background(Color(.systemBackground))
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
          }
        }
      }
      .frame(height: 200)
      .padding()
      .chartYScale(domain: viewModel.temperatureRange.min...viewModel.temperatureRange.max)
      .chartXAxis {
        AxisMarks(values: .stride(by: .hour, count: 6)) { value in
          if let date = value.as(Date.self) {
            AxisGridLine()
            AxisTick()
            AxisValueLabel {
              Text(date, format: .dateTime.hour().locale(Locale(identifier: "en_US")))
                .font(.footnote)
            }
          }
        }
      }
      .chartYAxis {
        AxisMarks { value in
          AxisGridLine()
          AxisTick()
          AxisValueLabel {
            if let temp = value.as(Double.self) {
              Text("\(Int(temp))°C")
            }
          }
        }
      }
      .chartOverlay { proxy in
        GeometryReader { geometry in
          Rectangle()
            .fill(.clear)
            .contentShape(Rectangle())
            .gesture(
              DragGesture()
                .onChanged { value in
                  let x = value.location.x - geometry[proxy.plotAreaFrame].origin.x
                  
                  let plotWidth = proxy.plotAreaSize.width
                  guard x >= 40, x <= (plotWidth - 20),
                        let date = proxy.value(atX: x) as Date? else {
                    return
                  }
                  
                  guard let hour = viewModel.todayTemperatures.first(where: {
                    Calendar.current.compare($0.date, to: date, toGranularity: .hour) == .orderedSame
                  }) else {
                    return
                  }
                  
                  viewModel.selectedHour = hour
                }
                .onEnded { _ in
                  viewModel.selectedHour = nil
                }
            )
        }
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
  TemperatureChartView(hourlyWeather: [
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
