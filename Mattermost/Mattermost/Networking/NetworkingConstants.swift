//
//  NetworkingConstants.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/20/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Moya
import Result

typealias CancellableRequest = Cancellable
typealias MoyaResult = Result<Moya.Response, Moya.Error>
