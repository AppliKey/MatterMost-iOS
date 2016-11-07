//
//  Mapping.swift
//  Mattermost
//
//  Created by torasike on 9/27/16.
//  Copyright © 2016 Applikey Solutions. All rights reserved.
//
 
import Foundation
import Alamofire

protocol ObjectMapper {
    associatedtype MappedType
    
    func performMapping(response: Any, completion: (_ result: Result<MappedType>) -> () )
}
