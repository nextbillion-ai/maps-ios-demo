//
//  NavigationView.swift
//  NBMapsDemo
//
//  Created by Lin Dan on 22/9/21.
//

import Foundation
import SwiftUI

struct FeatureOverview: View {
    let features = featureList()
    
    static func featureList() -> [Feature] {
        var features:[Feature] = [];
        let marker = Feature(name: "Marker", id: 0, description: "Example of markers", type: FeatureType.Marker)
        features.append(marker)
        features.append(Feature(name: "Polyline", id: 1, description: "Example of Polyline", type: FeatureType.Polyline))
        features.append(Feature(name: "Polygon", id: 2, description: "Example of Polygon", type: FeatureType.Polygon))
        features.append(Feature(name: "Directions", id: 3, description: "Example of Directions", type: FeatureType.Directions))
        features.append(Feature(name: "Matrix(WIP)", id: 4, description: "Example of Matrix", type: FeatureType.Matrix))
        features.append(Feature(name: "Matching", id: 5, description: "Example of Matching", type: FeatureType.Matching))
        
        return features
    }
    
    var body: some View {
        NavigationView {
            List(features, id: \.self){feature in
                NavigationLink(destination: FeatureView(feature: feature)) {
                    Text("\(feature.id) - \(feature.name) ")
                }
            }
            .navigationBarTitle("Maps SDK Features")
        }
    }
}
