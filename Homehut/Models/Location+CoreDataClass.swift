//
//  Location+CoreDataClass.swift
//  Homehut
//
//  Created by Jacob Fink on 6/15/21.
//
//

import Foundation
import CoreData

@objc(Location)
public class Location: NSManagedObject {
    
    var name: String {
        get { return nameValue ?? "" }
        set { nameValue = newValue }
    }
}
