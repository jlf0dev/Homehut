//
//  WorkItemModel.swift
//  Homehut
//
//  Created by Jacob Fink on 5/10/21.
//

import Foundation

struct WorkItemModel : Identifiable {
    var id: String = UUID().uuidString
    
    let title: String
    let startDate: Date
//    let endDate: Date?
//    let category: String
//    let recurringMode: String?
//    let tools: [String]?
//    let equipment: [String: Int]?
    let location: String? // Should be array
//    let notes: String?
//    let pictures:
    
    
    var startDateString: String { // TODO: formatters not cheap, change this
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, dd 'of' MMMM"
            return formatter.string(from: startDate)
    }
    
    var endDateString: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, dd 'of' MMMM"
            return formatter.string(from: startDate)
    }
}
