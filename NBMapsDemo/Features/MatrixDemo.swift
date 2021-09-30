import SwiftUI
import Nbmap

struct MatrixDemo: UIViewRepresentable {
    private let mapView:NGLMapView = NGLMapView(frame: .zero)
    
    
    func makeUIView(context: Context) -> some NGLMapView {
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 12.97551913, longitude: 77.58917229), zoomLevel: 12, animated: false)
//        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        updateAnnotations()
    }
    
//    func makeCoordinator() -> Coordinator {
//        return Coordinator()
//    }
    
    private func updateAnnotations() {
        let locations: [CLLocationCoordinate2D] =  [
            CLLocationCoordinate2D(latitude: 12.97780156, longitude: 77.59656748),
            CLLocationCoordinate2D(latitude: 12.98208919, longitude: 77.60329262)
        ]
        if let currentAnnotations = mapView.annotations {
            mapView.removeAnnotations(currentAnnotations)
        }
        
        mapView.addAnnotations(locations.map({(coord)->
            NGLPointAnnotation in
            let annotation = NGLPointAnnotation()
            annotation.coordinate = coord
            return annotation
        }))
    }
}
