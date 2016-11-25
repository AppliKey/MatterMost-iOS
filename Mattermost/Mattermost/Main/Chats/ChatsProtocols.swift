//
//  ChatsChatsProtocols.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 16/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

enum ChatsMode : Int {
    case unread
    case favourites
    case publicChats
    case privateChats
    case direct
}

protocol ChannelCellViewing {
    func configure(forRepresentationModel model:ChatRepresentationModel)
    var requests: [CancellableRequest] { get set }
}

protocol ChatsConfigurator: class {
}

protocol ChatsInteracting: class {
    func loadChannels()
}

protocol ChatsPresenting: class {
    func present(_ channels: [Channel])
    func present(_ errorMessage: String)
}

protocol ChatsViewing: ErrorShowable {
    func updateView(withRepresentationModel chatsRepresentation: [ChatRepresentationModel])
    func updateCell(atIndex index:Int, withModel model:ChatRepresentationModel)
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol ChatsEventHandling: class {
    func openMenu()
    func refresh()
}

protocol ChatsCoordinator: class {
    func openMenu()
}
