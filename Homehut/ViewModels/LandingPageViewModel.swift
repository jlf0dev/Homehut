//
//  LandingPageViewModel.swift
//  Homehut
//
//  Created by Jacob Fink on 5/10/21.
//

import Foundation

class LandingPageViewModel: ObservableObject {
    
    let data = [
        WorkItemModel(title: "Clean behind washer and dryer", startDate: Date.distantFuture, location: "Laundry Room"),
        WorkItemModel(title: "Replace Air Filters", startDate: Date.distantFuture, location: "Upstairs"),
        WorkItemModel(title: "Clean out gutters", startDate: Date.distantFuture, location: "Outside"),
        WorkItemModel(title: "Check under porch", startDate: Date.distantFuture, location: "Outside"),
        WorkItemModel(title: "Clean windows", startDate: Date.distantFuture, location: "Downstairs")
    ]
}
