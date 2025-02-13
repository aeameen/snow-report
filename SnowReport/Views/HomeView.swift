import SwiftUI
import Charts

struct HomeView: View {
  @StateObject private var viewModel = SnowReportViewModel()
  @State private var isSearching = false
  
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
        
        // Content
        VStack(spacing: 20) {
          if let resort = viewModel.selectedResort {
            ResortView(
              resort: resort,
              snowReports: viewModel.snowReports,
              isLoading: viewModel.isLoading,
              error: viewModel.error
            )
          } else {
            WelcomeView()
          }
        }
      }
      .navigationTitle(viewModel.selectedResort?.name ?? "")
      .navigationBarTitleDisplayMode(.large)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            isSearching = true
          } label: {
            Image(systemName: "magnifyingglass")
          }
        }
      }
      .sheet(isPresented: $isSearching) {
        SearchView(
          snowReportViewModel: viewModel,
          isPresented: $isSearching
        )
      }
    }
    .tint(.blue)  // Set navigation tint color
  }
}

struct ResortView: View {
  let resort: Resort
  let snowReports: [SnowReport]
  let isLoading: Bool
  let error: SnowReportError?
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 24) {
        // Location info with styled background
        HStack {
          Image(systemName: "location.fill")
            .foregroundColor(.blue)
          Text("\(Int(resort.latitude))°N, \(Int(abs(resort.longitude)))°W")
            .foregroundStyle(.secondary)
        }
        .padding()
        .background(
          RoundedRectangle(cornerRadius: 12)
            .fill(Color(.systemBackground))
            .shadow(radius: 2)
        )
        .padding(.horizontal)
        
        if isLoading {
          LoadingView()
        } else if let error = error {
          ErrorView(error: error)
        } else {
          SnowChartView(snowReports: snowReports)
          
          if let latest = snowReports.first {
            CurrentConditionsView(report: latest)
          }
        }
      }
      .padding(.vertical)
    }
    .background(Color.clear)  // Allow parent gradient to show through
  }
}

struct LoadingView: View {
  var body: some View {
    VStack(spacing: 20) {
      ProgressView()
        .scaleEffect(1.5)
      Text("Loading snow report...")
        .foregroundStyle(.secondary)
    }
    .frame(maxWidth: .infinity, maxHeight: 200)
  }
}

struct ErrorView: View {
  let error: SnowReportError
  
  var body: some View {
    VStack(spacing: 20) {
      Image(systemName: "exclamationmark.triangle")
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
