//
//  ChatsChatsWireframe.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 16/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

typealias ChatsConfiguration = (ChatsConfigurator) -> Void

class ChatsWireframe {
    
    class func setup(_ viewController: ChatsViewController,
                     withCoordinator coordinator: ChatsCoordinator,
                     service: ChannelsService,
                     mode:ChatsMode,
                     configutation: ChatsConfiguration? = nil) {
        let interactor = ChatsInteractor(service: service, mode: mode)
        let presenter = ChatsPresenter(coordinator: coordinator)
        presenter.view = viewController
        presenter.interactor = interactor
        viewController.eventHandler = presenter
        viewController.chatsService = service
        interactor.presenter = presenter
        interactor.loadChannels()
        configutation?(presenter)
    }    
}
