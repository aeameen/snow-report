import Foundation

struct ResortConfig {
  static let whistler = Resort(
    id: "whistler",
    name: "Whistler Blackcomb",
    location: "Whistler, BC",
    latitude: 50.1163,
    longitude: -122.9574
  )
  
  static let bigWhite = Resort(
    id: "bigwhite",
    name: "Big White Ski Resort",
    location: "Kelowna, BC",
    latitude: 49.7256,
    longitude: -118.9432
  )
  
  static let silverStar = Resort(
    id: "silverstar",
    name: "SilverStar Mountain Resort",
    location: "Vernon, BC",
    latitude: 50.3707,
    longitude: -119.0493
  )
  
  static let sunPeaks = Resort(
    id: "sunpeaks",
    name: "Sun Peaks Resort",
    location: "Sun Peaks, BC",
    latitude: 50.8927,
    longitude: -119.9064
  )
  
  static let whitewater = Resort(
    id: "whitewater",
    name: "Whitewater Ski Resort",
    location: "Nelson, BC",
    latitude: 49.4833,
    longitude: -117.1667
  )
  
  static let revelstoke = Resort(
    id: "revelstoke",
    name: "Revelstoke Mountain Resort",
    location: "Revelstoke, BC",
    latitude: 50.9583,
    longitude: -118.1636
  )
  
  static let fernie = Resort(
    id: "fernie",
    name: "Fernie Alpine Resort",
    location: "Fernie, BC",
    latitude: 49.4633,
    longitude: -115.0875
  )
  
  static let kicking = Resort(
    id: "kickinghorse",
    name: "Kicking Horse Mountain Resort",
    location: "Golden, BC",
    latitude: 51.2975,
    longitude: -117.0419
  )
  
  static let panorama = Resort(
    id: "panorama",
    name: "Panorama Mountain Resort",
    location: "Panorama, BC",
    latitude: 50.4583,
    longitude: -116.2367
  )
  
  static let apex = Resort(
    id: "apex",
    name: "Apex Mountain Resort",
    location: "Penticton, BC",
    latitude: 49.3917,
    longitude: -119.9061
  )
  
  static let cypress = Resort(
    id: "cypress",
    name: "Cypress Mountain",
    location: "West Vancouver, BC",
    latitude: 49.3967,
    longitude: -123.2045
  )
  
  static let grouse = Resort(
    id: "grouse",
    name: "Grouse Mountain",
    location: "North Vancouver, BC",
    latitude: 49.3792,
    longitude: -123.0816
  )
  
  static let seymour = Resort(
    id: "seymour",
    name: "Mount Seymour",
    location: "North Vancouver, BC",
    latitude: 49.3667,
    longitude: -122.9486
  )
  
  static let redMountain = Resort(
    id: "redmountain",
    name: "RED Mountain Resort",
    location: "Rossland, BC",
    latitude: 49.1000,
    longitude: -117.8167
  )
  
  static let baldy = Resort(
    id: "baldy",
    name: "Mount Baldy",
    location: "Oliver, BC",
    latitude: 49.1167,
    longitude: -119.1333
  )
  
  static let manning = Resort(
    id: "manning",
    name: "Manning Park Resort",
    location: "Manning Park, BC",
    latitude: 49.0833,
    longitude: -120.8333
  )
  
  static let sasquatch = Resort(
    id: "sasquatch",
    name: "Sasquatch Mountain Resort",
    location: "Agassiz, BC",
    latitude: 49.3833,
    longitude: -121.9500
  )
  
  static let hudsonBay = Resort(
    id: "hudsonbay",
    name: "Hudson Bay Mountain",
    location: "Smithers, BC",
    latitude: 54.7833,
    longitude: -127.1667
  )
  
  static let powderKing = Resort(
    id: "powderking",
    name: "Powder King Mountain",
    location: "Mackenzie, BC",
    latitude: 55.4333,
    longitude: -122.6167
  )
  
  static let purdenSki = Resort(
    id: "purden",
    name: "Purden Ski Village",
    location: "Prince George, BC",
    latitude: 53.9333,
    longitude: -121.9167
  )
  
  static let murrayRidge = Resort(
    id: "murrayridge",
    name: "Murray Ridge Ski Area",
    location: "Fort St. James, BC",
    latitude: 54.4500,
    longitude: -124.2500
  )
  
  // Comprehensive list of all resorts
  static let allResorts = [
    whistler,        // Largest resort in North America
    bigWhite,        // Okanagan
    silverStar,      // Okanagan
    sunPeaks,        // Interior
    whitewater,      // Kootenays
    revelstoke,      // World's longest vertical
    fernie,          // Powder skiing
    kicking,         // Rocky Mountains
    panorama,        // Rocky Mountains
    apex,            // Okanagan
    cypress,         // Vancouver local
    grouse,          // Vancouver local
    seymour,         // Vancouver local
    redMountain,     // Kootenays
    baldy,           // South Okanagan
    manning,         // Manning Park
    sasquatch,       // Fraser Valley
    hudsonBay,       // Northern BC
    powderKing,      // Northern BC
    purdenSki,       // Northern BC
    murrayRidge      // Northern BC
  ].sorted { $0.name < $1.name }  // Sort alphabetically
}
