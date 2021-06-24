//
//  HomehutApp.swift
//  Homehut
//
//  Created by Jacob Fink on 5/10/21.
//

import SwiftUI

@main
struct HomehutApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            LandingPageView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
