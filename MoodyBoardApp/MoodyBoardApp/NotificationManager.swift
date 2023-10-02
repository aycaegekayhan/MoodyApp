//
//  NotificationManager.swift
//  MoodyBoardApp
//
//  Created by Atilla Sivri on 10/2/23.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager() // Singleton instance
    
    private init() {} // Prevents others from creating additional instances
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Permission granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func scheduleDailyNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Good Morning!"
        content.body = "How are you feeling today?"
        content.sound = UNNotificationSound.default

        // Schedule notification for every day at 8am
        var dateComponents = DateComponents()
        dateComponents.hour = 8
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}

