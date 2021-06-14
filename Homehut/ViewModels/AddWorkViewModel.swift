//
//  AddWorkViewModel.swift
//  Homehut
//
//  Created by Jacob Fink on 5/14/21.
//

import Foundation

class AddWorkViewModel: ObservableObject {
        
    var CurrentLocation: Location {
        return locationData[3]
    }
    
    var LocationData: [Location] {
        locationData
    }
    
    let locationData = [
        Location("Upstairs"),
        Location("Downstairs"),
        Location("Outside"),
        Location("Inside"),
        Location("Kitchen"),
        Location("Bathroom"),
    ]
    
}
