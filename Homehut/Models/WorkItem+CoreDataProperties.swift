//
//  WorkItem+CoreDataProperties.swift
//  Homehut
//
//  Created by Jacob Fink on 6/16/21.
//
//

import Foundation
import CoreData


extension WorkItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkItem> {
        return NSFetchRequest<WorkItem>(entityName: "WorkItem")
    }

    @NSManaged public var dueDateValue: Date?
    @NSManaged public var notesValue: String?
    @NSManaged public var titleValue: String?
//    @NSManaged public var categoryValue: Int16
    @NSManaged public var locationsValue: NSSet?

}

// MARK: Generated accessors for location
extension WorkItem {

    @objc(addLocationObject:)
    @NSManaged public func addToLocation(_ value: Location)

    @objc(removeLocationObject:)
    @NSManaged public func removeFromLocation(_ value: Location)

    @objc(addLocation:)
    @NSManaged public func addToLocation(_ values: NSSet)

    @objc(removeLocation:)
    @NSManaged public func removeFromLocation(_ values: NSSet)

}

extension WorkItem : Identifiable {

}
