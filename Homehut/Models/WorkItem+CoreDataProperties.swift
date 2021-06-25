//
//  WorkItem+CoreDataProperties.swift
//  Homehut
//
//  Created by Jacob Fink on 6/24/21.
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
    @NSManaged public var locationsValue: NSSet?
    @NSManaged public var imagesValue: NSSet?

}

// MARK: Generated accessors for locationsValue
extension WorkItem {

    @objc(addLocationsValueObject:)
    @NSManaged public func addToLocationsValue(_ value: Location)

    @objc(removeLocationsValueObject:)
    @NSManaged public func removeFromLocationsValue(_ value: Location)

    @objc(addLocationsValue:)
    @NSManaged public func addToLocationsValue(_ values: NSSet)

    @objc(removeLocationsValue:)
    @NSManaged public func removeFromLocationsValue(_ values: NSSet)

}

// MARK: Generated accessors for imagesValue
extension WorkItem {

    @objc(addImagesValueObject:)
    @NSManaged public func addToImagesValue(_ value: WorkImage)

    @objc(removeImagesValueObject:)
    @NSManaged public func removeFromImagesValue(_ value: WorkImage)

    @objc(addImagesValue:)
    @NSManaged public func addToImagesValue(_ values: NSSet)

    @objc(removeImagesValue:)
    @NSManaged public func removeFromImagesValue(_ values: NSSet)

}

extension WorkItem : Identifiable {

}
