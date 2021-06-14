//
//  LandingPageViewModel.swift
//  Homehut
//
//  Created by Jacob Fink on 5/10/21.
//

import Foundation

class LandingPageViewModel: ObservableObject {
    
    
}

var previewData = [
    WorkItemModel(title: "Clean behind washer and dryer", category: CategoryType.general, dueDate: Date.distantFuture, location: [previewLocationData[0], previewLocationData[4]]),
    WorkItemModel(title: "Replace Air Filters", category: CategoryType.clean, dueDate: Date.distantFuture, location: [previewLocationData[0]]),
    WorkItemModel(title: "Clean out gutters", category: CategoryType.repair, dueDate: Date.distantFuture, location: [previewLocationData[2]]),
    WorkItemModel(title: "Check under porch", category: CategoryType.repair, dueDate: Date.distantFuture, location: [previewLocationData[3]]),
    WorkItemModel(title: "Clean windows", category: CategoryType.clean, dueDate: Date.distantFuture)
]

var previewLocationData = [
    Location("Upstairs"),
    Location("Downstairs"),
    Location("Outside"),
    Location("Inside"),
    Location("Kitchen"),
    Location("Bathroom"),
]
