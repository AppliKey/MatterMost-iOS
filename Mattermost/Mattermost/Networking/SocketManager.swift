//
//  SocketManager.swift
//  Mattermost
//
//  Created by iOS_Developer on 13.12.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit
import SocketRocket
import SwiftyJSON
import Unbox

fileprivate let socketPath = "/api/v3/users/websocket"

class SocketManager: NSObject {
    static let shared = SocketManager()
    
    var socketClient: SRWebSocket!
    
    func connect(toServerAddress address:String, withToken token:String) {
        guard let url = URL(string: address + socketPath)?.URLWithScheme(.WS)
            else { fatalError("Can't create url with address: \(address)") }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        socketClient = SRWebSocket(urlRequest: urlRequest)
        socketClient.delegate = self
        socketClient.open()
    }
    
    func closeConnection() {
        socketClient.close()
    }
}

extension SocketManager: SRWebSocketDelegate {
    func webSocketDidOpen(_ webSocket: SRWebSocket!) {
        debugPrint("webSocketDidOpen")
    }
    
    func webSocket(_ webSocket: SRWebSocket!, didReceiveMessage message: Any!) {
        guard let data = message as? Data
            else { return }
        
        let json = JSON(data: data)
        if let action =  json["action"].string {
            switch action {
            case "posted":
                if let props = json["props"].dictionary,
                   let postString = props["post"]?.string,
                   let postDict = JSON.parse(postString).dictionaryObject,
                   let post = try? unbox(dictionary: postDict) as Post {
                    handle(newPost: post)
                }
            default:
                debugPrint("didReceiveMessage - \(json)")
            }
        }
    }
    
    func handle(newPost post: Post) {
        guard let channel = post.channelId, let team = SessionManager.shared.team?.id
            else { return }
        
        post.isUnread = true
        NotificationCenter.default.post(Notification(name: .newPost(inChannel: channel), object: post, userInfo: nil))
        NotificationCenter.default.post(Notification(name: .newPost(inTeam: team), object: post, userInfo: nil))
    }
    
    func webSocket(_ webSocket: SRWebSocket!, didFailWithError error: Error!) {
        debugPrint("didFailWithError - \(error.localizedDescription)")
    }
    
    func webSocketShouldConvertTextFrame(toString webSocket: SRWebSocket!) -> Bool {
        return false
    }
}
