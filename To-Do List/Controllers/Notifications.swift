//
//  Notifications.swift
//  To-Do List
//
//  Created by Valera on 7/3/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import UIKit
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate  {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAutorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) {
            (granted, error) in
            print("Permission granted: \(granted)")
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { (settings) in
            print("Notification settings \(settings)")
        }
    }
    
    func sheduleNotification(notificationType: String, date: Date) {
        
        let content = UNMutableNotificationContent()
        let userAction = "User ACtion"
    
        content.title = "Notification"
        content.body =  notificationType
        content.sound = UNNotificationSound.default
//        content.badge = 1
        content.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
        content.categoryIdentifier = userAction
        
        let date = date
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let identifire = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: identifire, content: content, trigger:  trigger)
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        let snoozAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "Delete", title: "Delete", options: [.destructive])
        let category = UNNotificationCategory(identifier: userAction, actions: [snoozAction, deleteAction], intentIdentifiers: [], options: [])
        notificationCenter.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    //not finished
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        UIApplication.shared.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber - 1


        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:

            print("Default")
        case "Snooze":
            print("Snooze")
            
        default:
            print("1")
        }
    }
}
