//
//  WorkItemModel.swift
//  Homehut
//
//  Created by Jacob Fink on 5/10/21.
//

import Foundation
import SwiftUI


enum CategoryType: Int, CaseIterable {
    case general,
         clean,
         repair,
         maintenance,
         organize
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
                return Color(UIColor.systemRed)
            case .repair:
                return Color(UIColor.systemOrange)
            case .maintenance:
                return Color(UIColor.systemBlue)
            case .organize:
                return Color(UIColor.systemGreen)
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




