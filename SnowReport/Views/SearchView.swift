import SwiftUI

struct SearchView: View {
  @StateObject private var searchViewModel = SearchViewModel()
  @ObservedObject var snowReportViewModel: SnowReportViewModel
  @Binding var isPresented: Bool
  @State private var searchText = ""
  
  var body: some View {
    NavigationView {
      List {
        if searchText.isEmpty {
          Group {
            Section("British Columbia") {
              ForEach(searchViewModel.bcResorts) { resort in
                ResortRow(resort: resort) {
                  snowReportViewModel.selectResort(resort)
                  isPresented = false
                }
              }
            }
            
            Section("Alberta") {
              ForEach(searchViewModel.albertaResorts) { resort in
                ResortRow(resort: resort) {
                  snowReportViewModel.selectResort(resort)
                  isPresented = false
                }
              }
            }
            
            Section("Ontario") {
              ForEach(searchViewModel.ontarioResorts) { resort in
                ResortRow(resort: resort) {
                  snowReportViewModel.selectResort(resort)
                  isPresented = false
                }
              }
            }
            
            Section("Quebec") {
              ForEach(searchViewModel.quebecResorts) { resort in
                ResortRow(resort: resort) {
                  snowReportViewModel.selectResort(resort)
                  isPresented = false
                }
              }
            }
            
            Section("Atlantic Canada") {
              ForEach(searchViewModel.atlanticResorts) { resort in
                ResortRow(resort: resort) {
                  snowReportViewModel.selectResort(resort)
                  isPresented = false
                }
              }
            }
          }
        } else {
          ForEach(searchViewModel.suggestedResorts) { resort in
            ResortRow(resort: resort) {
              snowReportViewModel.selectResort(resort)
              isPresented = false
            }
          }
        }
      }
      .searchable(text: $searchText, prompt: "Search resorts")
      .onChange(of: searchText) { oldValue, newValue in
        searchViewModel.searchResorts(query: newValue)
      }
      .navigationTitle("Select Resort")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Button("Cancel") {
            isPresented = false
          }
        }
      }
    }
  }
}

// Helper view for consistent resort row presentation
struct ResortRow: View {
  let resort: Resort
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      HStack {
        VStack(alignment: .leading, spacing: 4) {
          Text(resort.name)
            .font(.headline)
          Text(resort.location)
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        
        Spacer()
        
        Image(systemName: "chevron.right")
          .font(.caption)
          .foregroundStyle(.secondary)
      }
      .contentShape(Rectangle())
    }
    .buttonStyle(.plain)
  }
}

#Preview {
  SearchView(
    snowReportViewModel: SnowReportViewModel(),
    isPresented: .constant(true)
  )
} 