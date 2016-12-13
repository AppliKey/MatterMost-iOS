//
//  SocketManager.swift
//  Mattermost
//
//  Created by iOS_Developer on 13.12.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit
import SocketRocket

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
}

extension SocketManager: SRWebSocketDelegate {
    func webSocketDidOpen(_ webSocket: SRWebSocket!) {
        print("webSocketDidOpen")
    }
    
    func webSocket(_ webSocket: SRWebSocket!, didReceiveMessage message: Any!) {
        print("didReceiveMessage - \(message as? String)")
    }
    
    func webSocket(_ webSocket: SRWebSocket!, didFailWithError error: Error!) {
        print("didFailWithError - \(error.localizedDescription)")
    }
    
    func webSocketShouldConvertTextFrame(toString webSocket: SRWebSocket!) -> Bool {
        return true
    }
}
