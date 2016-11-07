//
//  APIRoute.swift
//  Mattermost
//
//  Created by torasike on 10/11/16.
//  Copyright © 2016 Applikey Solutions. All rights reserved.
//

import Foundation
import Alamofire

protocol APIRoute {
    
    var path: String { get }
    var method: Alamofire.HTTPMethod { get }
    
}
