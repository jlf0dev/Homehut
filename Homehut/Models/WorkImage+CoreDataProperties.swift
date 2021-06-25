//
//  WorkImage+CoreDataProperties.swift
//  Homehut
//
//  Created by Jacob Fink on 6/24/21.
//
//

import Foundation
import CoreData


extension WorkImage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkImage> {
        return NSFetchRequest<WorkImage>(entityName: "WorkImage")
    }

    @NSManaged public var imageData: Data?
    @NSManaged public var order: Int16
    @NSManaged public var workItem: WorkItem?

}

extension WorkImage : Identifiable {

}
