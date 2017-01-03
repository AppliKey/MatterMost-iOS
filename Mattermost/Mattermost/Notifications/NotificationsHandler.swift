//
//  NotificationsHandler.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 12/27/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit
import UserNotifications
import Moya

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
        service.sendDeviceToken(deviceTokenString)
    }
    
    //MARK: - Private
    fileprivate let service = PushService()
    
}

class PushService: NetworkService {
    
    func sendDeviceToken(_ deviceToken: String) {
        let target = PushTokenTarget(deviceToken: deviceToken)
        _ = request(target) { result in
            switch result {
            case .success(let response):
                if let json = try? response.mapJSON(), let dictionary = json as? [String: Any] {
                    print(dictionary)
                }
                if let string = try? response.mapString() {
                    print(string)
                }
            case .failure(let error):
                let errorMessage = self.errorMapper.message(for: error)
                print(errorMessage)
            }
        }
    }
    
    //MARK: - Private
    fileprivate let errorMapper = ErrorMapper()
    
}

struct PushTokenTarget: MattermostTarget {
    let deviceToken: String
    
    let method: Moya.Method = .post
    let path = "/users/attach_device"
    
    var parameters: [String : Any]? {
        return ["device_id": "apple:\(deviceToken)"]
    }
}
