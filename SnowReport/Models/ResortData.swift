import Foundation

struct ResortData {
  static let resorts = [
    // British Columbia
    Resort(id: "whistler", name: "Whistler Blackcomb", location: "Whistler, BC", latitude: 50.1163, longitude: -122.9574),
    Resort(id: "bigwhite", name: "Big White", location: "Kelowna, BC", latitude: 49.7256, longitude: -118.9275),
    Resort(id: "revelstoke", name: "Revelstoke Mountain", location: "Revelstoke, BC", latitude: 50.9583, longitude: -118.1636),
    Resort(id: "sun_peaks", name: "Sun Peaks Resort", location: "Sun Peaks, BC", latitude: 50.8927, longitude: -119.9127),
    Resort(id: "silver_star", name: "SilverStar Mountain", location: "Vernon, BC", latitude: 50.3706, longitude: -119.0492),
    Resort(id: "kicking_horse", name: "Kicking Horse", location: "Golden, BC", latitude: 51.2975, longitude: -117.0419),
    Resort(id: "fernie", name: "Fernie Alpine", location: "Fernie, BC", latitude: 49.4633, longitude: -115.0875),
    Resort(id: "panorama", name: "Panorama Mountain", location: "Invermere, BC", latitude: 50.4583, longitude: -116.2366),
    Resort(id: "apex", name: "Apex Mountain", location: "Penticton, BC", latitude: 49.3953, longitude: -119.9057),
    Resort(id: "red_mountain", name: "RED Mountain", location: "Rossland, BC", latitude: 49.1000, longitude: -117.8167),
    Resort(id: "whitewater", name: "Whitewater Ski Resort", location: "Nelson, BC", latitude: 49.4833, longitude: -117.1667),
    Resort(id: "cypress", name: "Cypress Mountain", location: "West Vancouver, BC", latitude: 49.3967, longitude: -123.2045),
    Resort(id: "grouse", name: "Grouse Mountain", location: "North Vancouver, BC", latitude: 49.3795, longitude: -123.0825),
    Resort(id: "seymour", name: "Mount Seymour", location: "North Vancouver, BC", latitude: 49.3671, longitude: -122.9479),
    Resort(id: "hemlock", name: "Sasquatch Mountain", location: "Agassiz, BC", latitude: 49.3736, longitude: -121.9311),
    Resort(id: "hudson_bay", name: "Hudson Bay Mountain", location: "Smithers, BC", latitude: 54.7758, longitude: -127.1750),
    Resort(id: "powder_king", name: "Powder King", location: "Mackenzie, BC", latitude: 55.4333, longitude: -122.6167),
    Resort(id: "manning", name: "Manning Park Resort", location: "Manning Park, BC", latitude: 49.0667, longitude: -120.8833),
    
    // Vancouver Island Resorts
    Resort(id: "mount_washington", name: "Mount Washington", location: "Courtenay, BC", latitude: 49.7547, longitude: -125.2982),
    Resort(id: "mount_cain", name: "Mount Cain", location: "Port McNeill, BC", latitude: 50.2333, longitude: -126.3500),
    
    // Alberta
    Resort(id: "banff", name: "Banff Sunshine", location: "Banff, AB", latitude: 51.1152, longitude: -115.7631),
    Resort(id: "lake_louise", name: "Lake Louise", location: "Lake Louise, AB", latitude: 51.4254, longitude: -116.1773),
    Resort(id: "marmot", name: "Marmot Basin", location: "Jasper, AB", latitude: 52.8013, longitude: -118.0834),
    Resort(id: "nakiska", name: "Nakiska Ski Area", location: "Kananaskis, AB", latitude: 50.9434, longitude: -115.1571),
    Resort(id: "castle", name: "Castle Mountain", location: "Pincher Creek, AB", latitude: 49.3171, longitude: -114.4142),
    Resort(id: "canyon", name: "Canyon Ski Resort", location: "Red Deer, AB", latitude: 52.3055, longitude: -113.7977),
    Resort(id: "norquay", name: "Mount Norquay", location: "Banff, AB", latitude: 51.1927, longitude: -115.5929),
    Resort(id: "pass", name: "Pass Powderkeg", location: "Crowsnest Pass, AB", latitude: 49.6229, longitude: -114.6877),
    Resort(id: "kinosoo", name: "Kinosoo Ridge", location: "Cold Lake, AB", latitude: 54.4039, longitude: -110.2369),
    Resort(id: "rabbit", name: "Rabbit Hill", location: "Edmonton, AB", latitude: 53.4161, longitude: -113.6772),
    Resort(id: "snow_valley", name: "Snow Valley", location: "Edmonton, AB", latitude: 53.4669, longitude: -113.5833),
    Resort(id: "sunridge", name: "Sunridge Ski Area", location: "Edmonton, AB", latitude: 53.5716, longitude: -113.3778),
    Resort(id: "tawatinaw", name: "Tawatinaw Valley", location: "Tawatinaw, AB", latitude: 54.2931, longitude: -113.5214),
    Resort(id: "vista", name: "Vista Ridge", location: "Fort McMurray, AB", latitude: 56.7268, longitude: -111.4010),
    Resort(id: "nitehawk", name: "Nitehawk Adventure Park", location: "Grande Prairie, AB", latitude: 55.1700, longitude: -118.8030),
    
    // Ontario
    Resort(id: "blue", name: "Blue Mountain", location: "Blue Mountains, ON", latitude: 44.5015, longitude: -80.3085),
    Resort(id: "mount_stlouis", name: "Mount St. Louis Moonstone", location: "Coldwater, ON", latitude: 44.7357, longitude: -79.6881),
    Resort(id: "horseshoe", name: "Horseshoe Resort", location: "Barrie, ON", latitude: 44.5548, longitude: -79.7381),
    Resort(id: "calabogie", name: "Calabogie Peaks", location: "Calabogie, ON", latitude: 45.2928, longitude: -76.7775),
    
    // Quebec
    Resort(id: "tremblant", name: "Mont Tremblant", location: "Mont-Tremblant, QC", latitude: 46.2095, longitude: -74.5855),
    Resort(id: "stanne", name: "Mont Sainte-Anne", location: "Beaupré, QC", latitude: 47.0755, longitude: -70.9070),
    Resort(id: "le_massif", name: "Le Massif de Charlevoix", location: "Petite-Rivière-Saint-François, QC", latitude: 47.2789, longitude: -70.6147),
    Resort(id: "bromont", name: "Bromont", location: "Bromont, QC", latitude: 45.3167, longitude: -72.6500),
    Resort(id: "sutton", name: "Mont Sutton", location: "Sutton, QC", latitude: 45.1047, longitude: -72.5647),
    
    // Atlantic Canada
    Resort(id: "marble", name: "Marble Mountain", location: "Steady Brook, NL", latitude: 48.9511, longitude: -57.8306),
    Resort(id: "crabbe", name: "Crabbe Mountain", location: "Central Hainesville, NB", latitude: 46.1171, longitude: -67.1695),
    Resort(id: "wentworth", name: "Ski Wentworth", location: "Wentworth, NS", latitude: 45.6102, longitude: -63.5504)
  ]
}