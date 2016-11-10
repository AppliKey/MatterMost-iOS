//
//  KeychainService.swift
//  Mattermost
//
//  Created by torasike on 11/8/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

protocol NetworkBaseUrlProtocol {
    static func saveNetworkBaseUrl(baseUrl: URL)
    static func deleteNetworkBaseUrl()
    static func networkBaseUrl() -> URL?
}

class DefaultsService {
}

extension DefaultsService: NetworkBaseUrlProtocol {
    
    private static let NetworkBaseUrlKey = "network_base_url"

    static func saveNetworkBaseUrl(baseUrl: URL) {
        UserDefaults.setValue(baseUrl, forKey: NetworkBaseUrlKey)
    }

    static func deleteNetworkBaseUrl() {
        UserDefaults.setValue(nil, forKey: NetworkBaseUrlKey)
    }

    static func networkBaseUrl() -> URL? {
        return UserDefaults.value(forKey: NetworkBaseUrlKey) as? URL
    }
}
