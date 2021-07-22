//
//  NotificationManager.swift
//  Homehut
//
//  Created by Jacob Fink on 7/19/21.
//

import Foundation
import UserNotifications

final class NotificationManager: ObservableObject {
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    
    func reloadAuthorizationStatus() {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                DispatchQueue.main.async {
                    self.authorizationStatus = settings.authorizationStatus
                }
            }
        }
        
        func requestAuthorization() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isGranted, _ in
                DispatchQueue.main.async {
                    self.authorizationStatus = isGranted ? .authorized : .denied
                }
            }
        }
}
