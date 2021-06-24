//
//  Helpers.swift
//  Homehut
//
//  Created by Jacob Fink on 6/22/21.
//

import Foundation

extension Date {
  func toString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    return dateFormatter.string(from: self)

    }
}
