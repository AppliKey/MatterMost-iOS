//
//  ChatDetailsChatDetailsProtocols.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 01/12/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol PostsService {
    func requestPosts(offset:String, completion: @escaping PostsCompletion) -> CancellableRequest?
    func requestMorePosts(afterPost postId:String, completion: @escaping PostsCompletion) -> CancellableRequest?
}

protocol ChatDetailsConfigurator: class {
}

protocol ChatDetailsInteracting: class {
    func getMorePosts(completion: @escaping PostsCompletion)
}

protocol ChatDetailsPresenting: class {
}

protocol MessageCellViewing {
    func configure(withRepresentationModel model: PostRepresentationModel)
}

protocol ChatDetailsViewing: class {
    func addMorePosts(_ posts: [PostRepresentationModel])
}

protocol ChatDetailsEventHandling: class {
    func viewIsReady()
}

protocol ChatDetailsCoordinator: class {
}
