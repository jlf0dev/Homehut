//
//  WorkItem+CoreDataClass.swift
//  Homehut
//
//  Created by Jacob Fink on 6/15/21.
//
//

import Foundation
import CoreData
import SwiftUI

@objc(WorkItem)
public class WorkItem: NSManagedObject {
    @NSManaged fileprivate var categoryValue: Int16
    @NSManaged fileprivate var frequencyValue: String?
    
    var title: String {
        get { return titleValue ?? "" }
        set { titleValue = newValue }
    }
    
    var dueDate: Date {
        get { return dueDateValue ?? Date() }
        set { dueDateValue = newValue }
    }
    
    var category: CategoryType {
        get { return CategoryType(rawValue: Int(categoryValue)) ?? .general }
        set { categoryValue = Int16(newValue.rawValue) }
    }
    
    var frequency: FrequencyType {
        get { return FrequencyType(rawValue: frequencyValue ?? "") ?? .oneTime }
        set { frequencyValue = newValue.rawValue }
    }
    
    var notes: String {
        get { return notesValue ?? "" }
        set { notesValue = newValue }
    }
    
    var locations: Set<Location>? {
        get { return locationsValue as? Set<Location> }
        set { locationsValue = newValue as NSSet? }
    }
    
    var images: Set<WorkImage>? {
        get { return imagesValue as? Set<WorkImage> }
        set { imagesValue = newValue as NSSet? }
    }
    
    var uiImageArray: [UIImage]? {
        get { return images?.sorted(by: {$0.order < $1.order}).map { $0.image } }
    }
    
    convenience init(title: String = "", category: CategoryType = .general, dueDate: Date = Date(), frequency: FrequencyType = .oneTime, locations: Set<Location>? = nil, notes: String = "", insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "WorkItem", in: context)!
        self.init(entity: entity, insertInto: context)
        self.title = title
        self.category = category
        self.dueDate = dueDate
        self.frequency = frequency
        self.locations = locations
        self.notes = notes
    }

}
