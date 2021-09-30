import SwiftUI
import Nbmap

struct MarkerDemo: UIViewRepresentable {
    private let mapView:NGLMapView = NGLMapView(frame: .zero)
    
    
    func makeUIView(context: Context) -> some NGLMapView {
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 12.97551913, longitude: 77.58917229), zoomLevel: 12, animated: false)
        mapView.delegate = context.coordinator
        
    
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(context.coordinator.handleMapTap(sender:)))
        for recognizer in mapView.gestureRecognizers! where recognizer is UITapGestureRecognizer {
            singleTap.require(toFail: recognizer)
        }
        mapView.addGestureRecognizer(singleTap)
        
        return mapView
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        updateAnnotations()
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(map: mapView)
    }
    
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


class Coordinator: NSObject, NGLMapViewDelegate {

    var mapView: NGLMapView
    
    init(map: NGLMapView) {
        self.mapView = map
    }
 
    
    
    func mapView(_ mapView: NGLMapView, viewFor annotation: NGLAnnotation) -> NGLAnnotationView? {
        return nil
    }

    func mapView(_ mapView: NGLMapView, annotationCanShowCallout annotation: NGLAnnotation) -> Bool {
        return true
    }
    
    
    @objc @IBAction func handleMapTap(sender: UIGestureRecognizer) {
        print("on Map Tap")
        if sender.state == .ended {
            let point = sender.location(in: sender.view!)
            let touchCoordinate = mapView.convert(point, toCoordinateFrom: sender.view!)
            let touchLocation = CLLocation(latitude: touchCoordinate.latitude, longitude: touchCoordinate.longitude)
            print(touchCoordinate)
            print(touchLocation)
        }
    }

}

