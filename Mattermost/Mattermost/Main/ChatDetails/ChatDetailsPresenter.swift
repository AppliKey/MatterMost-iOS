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
                                       showBottomView: true, isUnread: post.isUnread, postStatus: .sended)
    }
    
}

extension ChatDetailsPresenter: ChatDetailsConfigurator {
}

extension ChatDetailsPresenter: ChatDetailsPresenting {
}

extension ChatDetailsPresenter: ChatDetailsEventHandling {
    
    func handleSendMessage(_ message:String) {
        interactor.sendMessage(message: message, completion: { result in
            switch result {
            case .success(let post):
                print(post)
            case .failure():
                print("failed to send a post")
            }
        })
        let postRepresentation = PostRepresentationModel(userName: SessionManager.shared.user?.username,
                                                         userAvatarUrl: SessionManager.shared.user?.avatarUrl,
                                                         userOnlineStatus: .online,
                                                         isDirectChat: interactor.channel.type == .direct,
                                                         message: message,
                                                         date: Date(),
                                                         topViewText: nil,
                                                         isMyMessage: true,
                                                         showAvatar: false,
                                                         showTopView: false,
                                                         showBottomView: true,
                                                         isUnread: false,
                                                         postStatus: .sending)
        view.insert(post: postRepresentation)
    }
    
    func handleAttachPressed() {
        view.alert("In development")
    }
    
    func viewIsReady() {
        loadMoreData()
    }
    
    func handlePagination() {
        loadMoreData()
    }
    
    func refresh() {
        view.showActivityIndicator()
        interactor.refresh { [weak self] result in
            self?.handleCompletion(withResult: result, isRefresh: true)
        }
    }
    
    private func loadMoreData() {
        view.showActivityIndicator()
        interactor.getMorePosts { [weak self] result in
            self?.handleCompletion(withResult: result)
        }
    }
    
    private func handleCompletion(withResult result: PostsResult, isRefresh: Bool = false) {
        DispatchQueue.main.async {
            self.view.hideActivityIndicator()
        }
        switch result {
        case .success(let posts):
            var postsModels = posts.map(transform)
            guard postsModels.count > 0 else {return}
            for index in (1..<posts.count).reversed() {
                postsModels[index].showBottomView = showBottomView(forPost: postsModels[index],
                                                                   previousPost: postsModels[index - 1])
                postsModels[index - 1].showTopView = showTopView(forPost: postsModels[index],
                                                                 previousPost: postsModels[index - 1])
                postsModels[index - 1].showAvatar = showAvatar(forPost: postsModels[index - 1],
                                                               previousPost: postsModels[index])
            }
            DispatchQueue.main.async {
                if isRefresh {
                    self.view.refreshData(withPosts: postsModels)
                } else {
                    self.view.addMorePosts(postsModels)
                }
            }
        case .failure(let errorMessage):
            DispatchQueue.main.async {
                self.view.alert(errorMessage)
            }
        default: break
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
