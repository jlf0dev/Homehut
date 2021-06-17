//
//  WorkItem+CoreDataClass.swift
//  Homehut
//
//  Created by Jacob Fink on 6/15/21.
//
//

import Foundation
import CoreData

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
        set { locationsValue = newValue as NSSet?}
    }
    

}
