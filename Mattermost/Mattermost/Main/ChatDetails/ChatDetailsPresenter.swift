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
        let isMyPost = post.userId == SessionManager.shared.user?.id
        let userName = post.user?.username ?? R.string.localizable.loadingMessagesTitle()
        return PostRepresentationModel(userName: userName, userAvatarUrl: post.user?.avatarUrl, userOnlineStatus: .offline,
                                       isDirectChat: interactor.channel.type == .direct,
                                       message: post.message, date: post.createDate, topViewText: nil,
                                       isMyMessage: isMyPost, showAvatar: true, showTopView: true,
                                       showBottomView: true, isUnread: post.isUnread)
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
                    guard let strongSelf = self else {return}
                    var postsModels = posts.map(strongSelf.transform)
                    for index in (1..<posts.count).reversed() {
                        postsModels[index].showBottomView = strongSelf.showBottomView(forPost: postsModels[index],
                                                                                      previousPost: postsModels[index - 1])
                        postsModels[index - 1].showTopView = strongSelf.showTopView(forPost: postsModels[index],
                                                                                    previousPost: postsModels[index - 1])
                        postsModels[index - 1].showAvatar = strongSelf.showAvatar(forPost: postsModels[index - 1],
                                                                                  previousPost: postsModels[index])
                    }
                    self?.view.addMorePosts(postsModels)
                }
            default: break
            }
        }
    }
    
    private func showBottomView(forPost post:PostRepresentationModel, previousPost:PostRepresentationModel) -> Bool {
        if let date = post.date, let previousDate = previousPost.date, post.userAvatarUrl == previousPost.userAvatarUrl {
            if DateHelper.fullDateTimeString(forDate: date) == DateHelper.fullDateTimeString(forDate: previousDate) {
                return false
            }
        }
        return true
    }
    
    private func showTopView(forPost post:PostRepresentationModel, previousPost:PostRepresentationModel) -> Bool {
        if let date = post.date, let previousDate = previousPost.date, !post.isUnread, !previousPost.isUnread {
            if DateHelper.prettyDateString(forDate: date) == DateHelper.prettyDateString(forDate: previousDate) {
                return false
            }
        }
        if post.isUnread && previousPost.isUnread {
            return false
        }
        return true
    }
    
    private func showAvatar(forPost post:PostRepresentationModel, previousPost:PostRepresentationModel) -> Bool {
        if post.isMyMessage {
            return false
        }
        if post.userAvatarUrl == previousPost.userAvatarUrl {
            return post.showTopView
        }
        return true
    }
    
}
