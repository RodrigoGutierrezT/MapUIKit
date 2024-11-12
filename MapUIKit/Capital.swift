//
//  Capital.swift
//  MapUIKit
//
//  Created by Rodrigo on 12-11-24.
//

import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let info: String
    
    init(title: String?, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }

}
