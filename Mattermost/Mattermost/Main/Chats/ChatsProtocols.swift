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

protocol ChatsService {
    func loadChannels(with mode:ChatsMode, completion: @escaping ChannelsCompletion)
    func refresh(with mode:ChatsMode, completion: @escaping ChannelsCompletion)
    func getDetails(for channel:Channel, completion: @escaping ChannelDetailsCompletion) -> CancellableRequest?
    func getLastMessage(for channel:Channel, completion: @escaping ChannelDetailsCompletion) -> CancellableRequest?
    func getUsersStatuses(completion: @escaping ChannelsCompletion) -> CancellableRequest
}

protocol ChannelCellViewing {
    func configure(for model:ChatRepresentationModel)
    var requests: [CancellableRequest] { get set }
}

protocol ChatsConfigurator: class {
}

protocol ChatsInteracting: class {
    func loadChannels()
    func refresh()
    func getChannelDetails(at index:Int) -> [CancellableRequest?]
    func getChannel(at index:Int) -> Channel?
}

protocol ChatsPresenting: class {
    func present(_ channels: [Channel])
    func present(_ errorMessage: String)
    func update(channel: Channel, at index:Int)
}

protocol ChatsViewing: AlertShowable {
    func updateView(with chatsRepresentation: [ChatRepresentationModel])
    func updateCell(at index:Int, with model:ChatRepresentationModel)
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol ChatsEventHandling: class {
    func openMenu()
    func refresh()
    func viewIsReady()
    func handleCellAppearing(at index:Int) -> [CancellableRequest?]
    func handleRowSelection(at index:Int)
}

protocol ChatsCoordinator: class {
    func openMenu()
    func openDetails(forChannel channel:Channel)
}
