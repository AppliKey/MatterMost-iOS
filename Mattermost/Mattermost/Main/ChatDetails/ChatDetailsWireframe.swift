//
//  ChatDetailsChatDetailsWireframe.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 01/12/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

typealias ChatDetailsConfiguration = (ChatDetailsConfigurator) -> Void

class ChatDetailsWireframe {
    
    class func setup(_ viewController: ChatDetailsViewController,
                     channel: Channel,
                     withCoordinator coordinator: ChatDetailsCoordinator,
                     configutation: ChatDetailsConfiguration? = nil) {
        let interactor = ChatDetailsInteractor()
        let presenter = ChatDetailsPresenter(coordinator: coordinator)
        presenter.view = viewController
        presenter.interactor = interactor
        viewController.eventHandler = presenter
        interactor.presenter = presenter
        interactor.channel = channel
        configutation?(presenter)
    }
    
}
