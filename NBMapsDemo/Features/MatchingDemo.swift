import SwiftUI
import Nbmap

struct MatchingDemo: UIViewRepresentable {
    private let mapView:NGLMapView = NGLMapView(frame: .zero)
    
    
    func makeUIView(context: Context) -> some NGLMapView {
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 12.97551913, longitude: 77.58917229), zoomLevel: 12, animated: false)
        getSnapToRoad()
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        updateAnnotations()
    }
    

    
    private func updateAnnotations() {
        let locations: [CLLocationCoordinate2D] =  [
            CLLocationCoordinate2D(latitude: 12.94685395, longitude: 77.57421511),
            CLLocationCoordinate2D(latitude: 12.96087173, longitude: 77.57567788),
            CLLocationCoordinate2D(latitude: 12.96628856, longitude: 77.58859895)
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
    
    private func getSnapToRoad() {
        let locations: [NBLocation] = [
            NBLocation().inti(withValues: 12.94685395, lng: 77.57421511),
            NBLocation().inti(withValues: 12.96087173, lng: 77.57567788),
            NBLocation().inti(withValues: 12.96628856, lng: 77.58859895),
        ]
        
        let apiClient: NBAPIClient = NBAPIClient()
        apiClient.getMatching(locations) { resp in
            let geometry:String? = resp?.geometry[0] as? String
            let routeline = GeometryDecoder.covert(toFeature: geometry, precision:5)
            let routeSource = NGLShapeSource.init(identifier: "snapped-route-style-source", shape: routeline)
            mapView.style?.addSource(routeSource)
            let routeLayer = NGLLineStyleLayer.init(identifier: "snapped-route-layer", source: routeSource)
            routeLayer.lineColor = NSExpression.init(forConstantValue: UIColor.red)
            routeLayer.lineWidth = NSExpression.init(forConstantValue: 2)
            mapView.style?.addLayer(routeLayer)
        }
    }
}
