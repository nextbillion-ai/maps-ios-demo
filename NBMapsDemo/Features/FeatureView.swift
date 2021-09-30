import SwiftUI
import Nbmap


struct FeatureView: View {
    let feature:Feature
    
    var body: some View {
        switch feature.type {
        case FeatureType.Marker:
            MarkerDemo().edgesIgnoringSafeArea(.vertical)
        case FeatureType.Polyline:
            PolylineDemo().edgesIgnoringSafeArea(.vertical)
        case FeatureType.Polygon:
            PolygonDemo().edgesIgnoringSafeArea(.vertical)
        case FeatureType.Directions:
            DirectionsDemo().edgesIgnoringSafeArea(.vertical)
        case FeatureType.Matrix:
            MatrixDemo().edgesIgnoringSafeArea(.vertical)
        case FeatureType.Matching:
            MatchingDemo().edgesIgnoringSafeArea(.vertical)
        }
    }
}
