//
//  WorkItemModel.swift
//  Homehut
//
//  Created by Jacob Fink on 5/10/21.
//

import Foundation
import SwiftUI

//struct WorkItemModel : Identifiable {
//    let id: String = UUID().uuidString
//    
//    var title: String
//    var category: CategoryType
//    var dueDate: Date
//    var frequency: FrequencyType
////    let tools: [String]?
////    let materials: [String: Int]?
//    var location: [Location]? // TODO: Should be array
//    var notes: String?
////    let pictures:
//    
//    init(title: String = "", category: CategoryType = .general, dueDate: Date = Date(), frequency: FrequencyType = .oneTime, location: [Location]? = nil, notes: String? = nil) {
//        self.title = title
//        self.category = category
//        self.dueDate = dueDate
//        self.frequency = frequency
//        self.location = location
//        self.notes = notes
//    }
//    
//}
//
//struct Location: Identifiable {
//        let id = UUID().uuidString
//        var name: String
//    
//    init(_ name: String){
//        self.name = name
//    }
//}

enum CategoryType: Int {
    case general,
         clean,
         repair
    var label: String {
        return String(describing: self)
    }
}

extension CategoryType {
    var backgroundColor: Color {
        get {
            switch self {
            case .general:
                return Color.black
            case .clean:
                return Color.red
            case .repair:
                return Color.orange
            }
        }
    }
}


enum FrequencyType: String, Codable, CaseIterable, Identifiable {
    var id: FrequencyType {self}
    
    case oneTime = "One Time",
         weekly = "Weekly",
         monthly = "Monthly",
         yearly = "Yearly"
}

extension Optional where Wrapped == String {
    var _bound: String? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: String {
        get {
            return _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}



