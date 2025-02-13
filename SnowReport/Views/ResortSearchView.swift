import SwiftUI

struct ResortSearchView: View {
  @Environment(\.dismiss) private var dismiss
  @StateObject private var viewModel = ResortSearchViewModel()
  let onResortSelected: (Resort) -> Void
  
  var body: some View {
    NavigationView {
      List(viewModel.filteredResorts) { resort in
        Button {
          onResortSelected(resort)
          dismiss()
        } label: {
          VStack(alignment: .leading, spacing: 4) {
            Text(resort.name)
              .font(.headline)
              .foregroundColor(.primary)
            Text(resort.location)
              .font(.subheadline)
              .foregroundColor(.secondary)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
      }
      .listStyle(.plain)
      .searchable(text: $viewModel.searchText, prompt: Strings.Search.searchPrompt)
      .navigationTitle(Strings.Search.title)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button(Strings.Search.cancel) {
            dismiss()
          }
        }
      }
    }
  }
} 
