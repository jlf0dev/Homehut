//
//  WorkItemModel.swift
//  Homehut
//
//  Created by Jacob Fink on 5/10/21.
//

import Foundation
import SwiftUI

struct WorkItemModel : Identifiable {
    let id: String = UUID().uuidString
    
    var title: String
    var category: CategoryType
    var dueDate: Date
    var frequency: FrequencyType
//    let tools: [String]?
//    let materials: [String: Int]?
    var location: [Location]? // TODO: Should be array
    var notes: String?
//    let pictures:
    
    init(title: String = "", category: CategoryType = .general, dueDate: Date = Date(), frequency: FrequencyType = .oneTime, location: [Location]? = nil, notes: String? = nil) {
        self.title = title
        self.category = category
        self.dueDate = dueDate
        self.frequency = frequency
        self.location = location
        self.notes = notes
    }
    
}

struct Location: Identifiable {
        let id = UUID().uuidString
        var name: String
    
    init(_ name: String){
        self.name = name
    }
}

public enum CategoryType: String, Codable {
    case general,
         clean,
         repair
}

enum FrequencyType: String, Codable, CaseIterable, Identifiable {
    var id: FrequencyType {self}
    
    case oneTime = "One Time",
         weekly = "Weekly",
         monthly = "Monthly",
         yearly = "Yearly"
}




