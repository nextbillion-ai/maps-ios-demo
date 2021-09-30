import SwiftUI
import Nbmap



struct DirectionsDemo: UIViewRepresentable {
    private let mapView:NGLMapView = NGLMapView(frame: .zero)
    private let apiClient: NBAPIClient = NBAPIClient()
    
    
    
    
    func makeUIView(context: Context) -> some NGLMapView {
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 12.97551913, longitude: 77.58917229), zoomLevel: 12, animated: false)
        getDirections()
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        updateAnnotations()
    }
    
    private func updateAnnotations() {
        let locations: [CLLocationCoordinate2D] =  [
            CLLocationCoordinate2D(latitude: 12.96206481, longitude: 77.56687669),
            CLLocationCoordinate2D(latitude: 12.99150562, longitude: 77.61940507)
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
    
    private func getDirections() {
        let locations: [CLLocationCoordinate2D] =  [
            CLLocationCoordinate2D(latitude: 12.96206481, longitude: 77.56687669),
            CLLocationCoordinate2D(latitude: 12.99150562, longitude: 77.61940507)
        ]

        apiClient.getDirections(locations) {
            resp in
            
            let first = resp?.routes.first;
            if first is NBRoute {
                let route:NBRoute? = first as? NBRoute
                let geometry = route?.geometry
                let routeline = GeometryDecoder.covert(toFeature: geometry, precision:5)
                let routeSource = NGLShapeSource.init(identifier: "route-style-source", shape: routeline)
                mapView.style?.addSource(routeSource)
                let routeLayer = NGLLineStyleLayer.init(identifier: "route-layer", source: routeSource)
                routeLayer.lineColor = NSExpression.init(forConstantValue: UIColor.red)
                routeLayer.lineWidth = NSExpression.init(forConstantValue: 2)
            
                mapView.style?.addLayer(routeLayer)

            }
        }
        
    }
}
