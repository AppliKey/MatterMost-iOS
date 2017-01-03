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
    var replyedPost: PostRepresentationModel?
    
    func transform(post:Post) -> PostRepresentationModel {
        let isMyPost = post.userId == SessionManager.shared.user?.id
        let userName = post.user?.username ?? R.string.localizable.loadingMessagesTitle()
        return PostRepresentationModel(userName: userName, userAvatarUrl: post.user?.avatarUrl, userOnlineStatus: .offline,
                                       isDirectChat: interactor.channel.type == .direct,
                                       message: post.message, date: post.createDate, topViewText: nil,
                                       isMyMessage: isMyPost, showAvatar: true, showTopView: true,
                                       showBottomView: true, isUnread: post.isUnread, postStatus: .sended, postId: post.id,
                                       replyMessageId: post.rootId,
                                       placeholderId: post.pendingPostId)
    }
    
    fileprivate func getPlaceholder(withMessage message:String, placeholderId: String) -> PostRepresentationModel {
        return PostRepresentationModel(userName: SessionManager.shared.user?.username,
                                       userAvatarUrl: SessionManager.shared.user?.avatarUrl,
                                       userOnlineStatus: .online,
                                       isDirectChat: interactor.channel.type == .direct,
                                       message: message, date: Date(), topViewText: nil,
                                       isMyMessage: true, showAvatar: false, showTopView: false,
                                       showBottomView: true, isUnread: false, postStatus: .sending, postId: nil,
                                       replyMessageId: self.replyedPost?.postId, placeholderId: placeholderId)
    }
    
}

extension ChatDetailsPresenter: ChatDetailsConfigurator {
}

extension ChatDetailsPresenter: ChatDetailsPresenting {
    func addNew(post:Post) {
        view.insert(post: transform(post: post))
    }        
}

extension ChatDetailsPresenter: ChatDetailsEventHandling {
    
    func handleReply(post: PostRepresentationModel) {
        view.showReplyPost(post)
        replyedPost = post
    }
    
    func handleCloseReply() {
        view.closeReply()
        replyedPost = nil
    }
    
    func handleSendMessage(_ message:String) {
        let placeholderId = interactor.sendMessage(message: message, replyId: self.replyedPost?.postId, completion: { [weak self] result in
            switch result {
            case .success(let post):
                self?.interactor.updateLastPost(with: post)
                if let model = self?.transform(post: post) {
                    DispatchQueue.main.async {
                        self?.view.update(post: model)
                    }
                }
            case .failure(let placeholder):
                DispatchQueue.main.async {
                    self?.view.showError(forPostWithPlaceholderId: placeholder)
                }
            }
        })
        view.insert(post: getPlaceholder(withMessage: message, placeholderId: placeholderId))
        handleCloseReply()
    }
    
    func handleRetry(forPlaceholderPost placeholder: PostRepresentationModel) {
        let _ = interactor.sendMessage(message: placeholder.message!, replyId: placeholder.replyMessageId, completion: { [weak self] result in
            switch result {
            case .success(let post):
                var model = self?.transform(post: post)
                model?.placeholderId = placeholder.placeholderId
                if let model = model {
                    DispatchQueue.main.async {
                        self?.view.update(post: model)
                    }
                }
            case .failure(let placeholder):
                DispatchQueue.main.async {
                    self?.view.showError(forPostWithPlaceholderId: placeholder)
                }
            }
        })
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
    
    func handleBack() {
        coordinator.handleBack()
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
                postsModels[index].showBottomView = PostRepresentationModel.showBottomView(forPost: postsModels[index],
                                                                                           previousPost: postsModels[index - 1])
                postsModels[index - 1].showTopView = PostRepresentationModel.showTopView(forPost: postsModels[index],
                                                                                         previousPost: postsModels[index - 1])
                postsModels[index - 1].showAvatar = PostRepresentationModel.showAvatar(forPost: postsModels[index - 1],
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
}
