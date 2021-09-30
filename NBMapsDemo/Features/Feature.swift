import Foundation


enum FeatureType {
    case Marker
    case Polyline
    case Polygon
    case Directions
    case Matrix
    case Matching
}

struct Feature : Hashable {
    let name: String
    let id: Int
    let description: String
    let type: FeatureType
    
    var hashValue: Int {
        return id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
}
