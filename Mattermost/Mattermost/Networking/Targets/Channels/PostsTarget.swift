//
//  ChatsTarget.swift
//  Mattermost
//
//  Created by iOS_Developer on 24.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Moya
import Result
import Unbox

struct PostsTarget: MattermostTarget, ResponseMapping {
    
    //MARK: - Properties
    let teamId: String
    let channelId: String
    let offset: String
    let limit: String
    
    //MARK: - MattermostTarget -
    
    var path:String {
        return "/teams/" + teamId + "/channels/" + channelId + "/posts/page/" + offset + "/" + limit
    }
    
    func map(_ response: Moya.Response) throws -> [Post] {
        if let json = try response.mapJSON() as? UnboxableDictionary, let postsJson = json["posts"] as? UnboxableDictionary {
            var posts: [Post] = []
            for key in postsJson.keys {
                if let post = try? unbox(dictionary: postsJson, atKey: key) as Post {
                    posts.append(post)
                }
            }
            return posts
        } else {
            throw UnboxError(message: "Invalid json")
        }
    }
}
