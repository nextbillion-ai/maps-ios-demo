import SwiftUI
import Nbmap

struct PolygonDemo: UIViewRepresentable {
    private let mapView:NGLMapView = NGLMapView(frame: .zero)
    
    func makeUIView(context: Context) -> some NGLMapView {
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 12.94798778, longitude: 77.57375084), zoomLevel: 13, animated: true)
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        updateAnnotations()
    }

    
    private func updateAnnotations() {
        let locations: [CLLocationCoordinate2D] =  [
            CLLocationCoordinate2D(latitude: 12.94798778, longitude: 77.57375084),
            CLLocationCoordinate2D(latitude: 12.93669616, longitude: 77.57385337),
            CLLocationCoordinate2D(latitude: 12.93639637, longitude: 77.58031279),
            CLLocationCoordinate2D(latitude: 12.94808770, longitude: 77.58000520)
        ]
        if let currentAnnotations = mapView.annotations {
            mapView.removeAnnotations(currentAnnotations)
        }
        
        let polygon: NGLPolygon = NGLPolygon.init(coordinates: locations, count: 4)
        mapView.addAnnotation(polygon)
    }
}
