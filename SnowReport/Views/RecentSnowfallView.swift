import SwiftUI

struct RecentSnowfallView: View {
  @StateObject private var viewModel = RecentSnowfallViewModel()
  let hourlyWeather: [HourlyWeather]
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      VStack(alignment: .leading, spacing: 16) {
        Text(Strings.RecentSnowfall.title)
          .font(.title2)
          .bold()
          .padding(.horizontal)
        
        VStack(spacing: 24) {
          // First row: Overnight and Last 24h
          HStack(alignment: .center, spacing: 24) {
            // Overnight
            VStack(spacing: 8) {
              Text("\(Int(round(viewModel.overnight)))cm")
                .font(.system(size: 24, weight: .bold))
                .frame(height: 28)
              Text(Strings.RecentSnowfall.overnight)
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            
            // Last 24h
            VStack(spacing: 8) {
              Text("\(Int(round(viewModel.last24h)))cm")
                .font(.system(size: 24, weight: .bold))
                .frame(height: 28)
              Text(Strings.RecentSnowfall.last24h)
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
          }
          
          // Second row: Last 2 Days and Last Week
          HStack(alignment: .center, spacing: 24) {
            // Last 2 Days
            VStack(spacing: 8) {
              Text("\(Int(round(viewModel.last2days)))cm")
                .font(.system(size: 24, weight: .bold))
                .frame(height: 28)
              Text(Strings.RecentSnowfall.last2Days)
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            
            // Last Week
            VStack(spacing: 8) {
              Text("\(Int(round(viewModel.lastWeek)))cm")
                .font(.system(size: 24, weight: .bold))
                .frame(height: 28)
              Text(Strings.RecentSnowfall.lastWeek)
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
    .onAppear {
      viewModel.calculateSnowfall(from: hourlyWeather)
    }
    .onChange(of: hourlyWeather) { _, newValue in
      viewModel.calculateSnowfall(from: newValue)
    }
  }
} 
