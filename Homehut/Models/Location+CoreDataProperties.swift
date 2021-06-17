//
//  Location+CoreDataProperties.swift
//  Homehut
//
//  Created by Jacob Fink on 6/15/21.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var nameValue: String?
    @NSManaged public var workItem: NSSet?

}

// MARK: Generated accessors for workItem
extension Location {

    @objc(addWorkItemObject:)
    @NSManaged public func addToWorkItem(_ value: WorkItem)

    @objc(removeWorkItemObject:)
    @NSManaged public func removeFromWorkItem(_ value: WorkItem)

    @objc(addWorkItem:)
    @NSManaged public func addToWorkItem(_ values: NSSet)

    @objc(removeWorkItem:)
    @NSManaged public func removeFromWorkItem(_ values: NSSet)

}

extension Location : Identifiable {

}
