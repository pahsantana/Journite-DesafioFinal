//
//  Address.swift
//  Journite-DesafioFinal
//
//  Created by Paloma Cristina Santana on 13/05/22.
//

import UIKit
import CoreLocation
import Contacts

struct Address {
    var name: String
    var placemark: CLPlacemark
    var postalAddress: CNPostalAddress
    
    init(name: String, placemark: CLPlacemark, postalAddress: CNPostalAddress) {
        self.name          = name
        self.placemark     = placemark
        self.postalAddress = postalAddress
    }
}
