//
//  NotificationsHandler.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 12/27/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationsHandler {
    
    func register() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func sendToken(_ deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        print("Device token: \(deviceTokenString)")
        //TODO: send to server
    }
    
}
