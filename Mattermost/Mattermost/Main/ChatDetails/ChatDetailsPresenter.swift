//
//  ChatDetailsChatDetailsPresenter.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 01/12/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class ChatDetailsPresenter {
    
	//MARK: - Properties
    weak var view: ChatDetailsViewing!
    var interactor: ChatDetailsInteracting!
	
	//MARK: - Init
    
    required init(coordinator: ChatDetailsCoordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: - Private -
    fileprivate let coordinator: ChatDetailsCoordinator
    
    func transform(post:Post) -> PostRepresentationModel {
        let date = post.updateDate != nil ? post.updateDate! : post.createDate
        let isMyPost = post.userId == SessionManager.shared.user?.id
        return PostRepresentationModel(userName: post.userId, userAvatarUrl: nil,
                                       message: post.message, date: date, topViewText: nil,
                                       isMyMessage: isMyPost, showAvatar: false, showTopView: false, showBottomView: true)
    }
}

extension ChatDetailsPresenter: ChatDetailsConfigurator {
}

extension ChatDetailsPresenter: ChatDetailsPresenting {
}

extension ChatDetailsPresenter: ChatDetailsEventHandling {
    
    func viewIsReady() {
        interactor.getMorePosts { [weak self] result in
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    var postsModels = posts.map(self!.transform)
                    for index in posts.count - 1...0 {
                        
                    }
                    self?.view.addMorePosts(postsModels)
                }
            default: break
            }
        }
    }
    
}
