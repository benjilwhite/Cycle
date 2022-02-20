//
//  MKCoordinateRegion+Extensions.swift
//  Recycling Locator
//
//  Created by Benjamin White on 2/19/22.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    
    static var defaultRegion: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D.init(latitude: 29.726819, longitude: -95.393692), latitudinalMeters: 100, longitudinalMeters: 100)
    }
}
extension CLLocationCoordinate2D {
    
    static var defaultLocation: CLLocationCoordinate2D {
        CLLocationCoordinate2D.init(latitude: 29.726819, longitude: -95.393692)
    }
}
