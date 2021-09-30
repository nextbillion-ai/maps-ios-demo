import SwiftUI
import Nbmap

struct PolylineDemo: UIViewRepresentable {
    private let mapView:NGLMapView = NGLMapView(frame: .zero)
    
    
    func makeUIView(context: Context) -> some NGLMapView {
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 12.96612918, longitude: 77.60678866), zoomLevel: 12, animated: false)
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        updateAnnotations()
    }

    
    private func updateAnnotations() {
        let locations: [CLLocationCoordinate2D] =  [
            CLLocationCoordinate2D(latitude: 12.92948165, longitude: 77.61501446),
            CLLocationCoordinate2D(latitude: 12.95205978, longitude: 77.60494206),
            CLLocationCoordinate2D(latitude: 12.96612918, longitude: 77.60678866),
            CLLocationCoordinate2D(latitude: 12.96449325, longitude: 77.59654839)
        ]
        
        if let currentAnnotations = mapView.annotations {
            mapView.removeAnnotations(currentAnnotations)
        }
        
        
        let polyline: NGLPolyline = NGLPolyline.init(coordinates: locations, count: 4)
        mapView.addAnnotation(polyline)
        
        let source: NGLShapeSource = NGLShapeSource(identifier: "polyline", shape: polyline)
        guard let style = self.mapView.style else { return }
        style.addSource(source)
        let layer = NGLLineStyleLayer(identifier: "polyline-layer", source: source)
        // Set the line join and cap to a rounded end.
        layer.lineJoin = NSExpression(forConstantValue: "round")
        layer.lineCap = NSExpression(forConstantValue: "round")
         
        // Set the line color to a constant blue color.
        layer.lineColor = NSExpression(forConstantValue: UIColor(red: 255/255, green: 78/255, blue: 208/255, alpha: 1))
        layer.lineWidth = NSExpression(forConstantValue: 2)
        
        style.addLayer(layer)
    }
}
