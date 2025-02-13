import SwiftUI
import Charts

struct SnowChartView: View {
  let snowReports: [SnowReport]
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("Snowfall")
        .font(.title2)
        .bold()
        .padding(.horizontal)
      
      Chart(snowReports, id: \.date) { report in
        BarMark(
          x: .value("Date", report.date, unit: .day),
          y: .value("Snowfall", report.snowfall)
        )
        .foregroundStyle(
          report.date <= Date() 
          ? Gradient(colors: [.blue.opacity(0.8), .blue])
          : Gradient(colors: [.blue.opacity(0.4), .blue.opacity(0.6)])
        )
        .cornerRadius(8)
      }
      .frame(height: 200)
      .padding(.horizontal)
      .chartXAxis {
        AxisMarks(values: .stride(by: .day)) { value in
          if let date = value.as(Date.self) {
            AxisValueLabel {
              if date <= Date() {
                Text(date, format: .dateTime.weekday())
                  .foregroundStyle(.primary)
              } else {
                Text(date, format: .dateTime.weekday())
                  .foregroundStyle(.secondary)
              }
            }
          }
        }
      }
      .chartYAxis {
        AxisMarks { value in
          AxisValueLabel("\(value.index)cm")
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
  SnowChartView(snowReports: [
    SnowReport(date: Date(), snowfall: 10, temperature: -5, conditions: "Snow"),
    SnowReport(date: Date().addingTimeInterval(86400), snowfall: 5, temperature: -2, conditions: "Clear")
  ])
} 
