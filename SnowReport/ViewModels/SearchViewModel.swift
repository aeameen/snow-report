import Foundation

@MainActor
class SearchViewModel: ObservableObject {
  @Published var suggestedResorts: [Resort] = []
  
  private let resorts = ResortData.resorts
  
  // Computed properties for grouped resorts
  var bcResorts: [Resort] {
    resorts
      .filter { resort in resort.location.hasSuffix("BC") }
      .sorted { $0.name < $1.name }
  }
  
  var albertaResorts: [Resort] {
    resorts
      .filter { resort in resort.location.hasSuffix("AB") }
      .sorted { $0.name < $1.name }
  }
  
  var ontarioResorts: [Resort] {
    resorts
      .filter { resort in resort.location.hasSuffix("ON") }
      .sorted { $0.name < $1.name }
  }
  
  var quebecResorts: [Resort] {
    resorts
      .filter { resort in resort.location.hasSuffix("QC") }
      .sorted { $0.name < $1.name }
  }
  
  var atlanticResorts: [Resort] {
    resorts
      .filter { resort in 
        resort.location.hasSuffix("NL") || 
        resort.location.hasSuffix("NB") || 
        resort.location.hasSuffix("NS")
      }
      .sorted { $0.name < $1.name }
  }
  
  func searchResorts(query: String) {
    guard !query.isEmpty else {
      suggestedResorts = []
      return
    }
    
    suggestedResorts = resorts.filter { resort in
      let searchText = resort.name.lowercased()
      let searchTerms = query.lowercased().split(separator: " ")
      
      return searchTerms.allSatisfy { term in
        searchText.contains(term)
      }
    }
  }
} 
