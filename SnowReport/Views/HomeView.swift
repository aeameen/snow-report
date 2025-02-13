import SwiftUI
import Charts

struct HomeView: View {
  @StateObject private var viewModel = HomeViewModel()
  @State private var showingSearch = false
  
  var body: some View {
    NavigationView {
      ZStack {
        // Background gradient
        LinearGradient(
          colors: [
            Color(.systemBackground),
            Color.blue.opacity(0.1),
            Color.blue.opacity(0.2)
          ],
          startPoint: .top,
          endPoint: .bottom
        )
        .ignoresSafeArea()
        
        // Remove outer VStack and move refreshable to ScrollView
        ScrollView {
          ResortView(
            resort: viewModel.resort,
            snowReports: viewModel.snowReports,
            hourlyTemperatures: viewModel.hourlyTemperatures,
            isInitialLoad: viewModel.isInitialLoad,
            isLoading: viewModel.isLoading,
            error: viewModel.error
          )
        }
        .refreshable {
          await viewModel.fetchWeatherData()
        }
      }
      .navigationTitle(viewModel.resort.name)
      .navigationBarTitleDisplayMode(.large)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button {
            showingSearch = true
          } label: {
            Image(systemName: "magnifyingglass")
          }
        }
      }
      .sheet(isPresented: $showingSearch) {
        ResortSearchView { selectedResort in
          viewModel.updateResort(selectedResort)
        }
      }
    }
    .tint(.blue)  // Set navigation tint color
  }
}

struct ResortView: View {
  let resort: Resort
  let snowReports: [SnowReport]
  let hourlyTemperatures: [HourlyWeather]
  let isInitialLoad: Bool
  let isLoading: Bool
  let error: OpenMeteoError?
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        if isLoading {
          LoadingView()
        } else if let error = error {
          ErrorView(error: error)
        } else {
          if let latest = snowReports.first {
            CurrentConditionsView(report: latest)
            RecentSnowfallView(hourlyWeather: hourlyTemperatures)
            SnowfallChartView(snowReports: snowReports, hourlyWeather: hourlyTemperatures)
            TemperatureChartView(hourlyWeather: hourlyTemperatures)
          }
          
          // Attribution at bottom of content
          Text(Strings.Home.attribution)
            .font(.caption)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 8)
        }
      }
      .padding(.vertical)
    }
    .background(Color.clear)
  }
}

struct LoadingView: View {
  var body: some View {
    VStack(spacing: 20) {
      ProgressView()
        .scaleEffect(1.5)
      Text(Strings.Home.loading)
        .foregroundStyle(.secondary)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)  // Fill available space
  }
}

struct ErrorView: View {
  let error: OpenMeteoError
  
  var body: some View {
    VStack(spacing: 20) {
      Image(systemName: Icons.Weather.error)
        .font(.system(size: 50))
        .foregroundColor(.red)
      Text(error.localizedDescription)
        .multilineTextAlignment(.center)
        .foregroundStyle(.secondary)
    }
    .frame(maxWidth: .infinity, maxHeight: 200)
    .padding()
  }
}

#Preview {
  HomeView()
}
