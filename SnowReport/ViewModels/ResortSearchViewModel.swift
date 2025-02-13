import Foundation

@MainActor
class ResortSearchViewModel: ObservableObject {
  @Published var searchText = ""
  let resorts = ResortConfig.allResorts
  
  var filteredResorts: [Resort] {
    if searchText.isEmpty {
      return resorts
    }
    return resorts.filter { resort in
      resort.name.localizedCaseInsensitiveContains(searchText) ||
      resort.location.localizedCaseInsensitiveContains(searchText)
    }
  }
}
