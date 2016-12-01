//
//  ServerSelectionServerSelectionInteractor.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 27/10/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import Rswift

class ServerSelectionInteractor {
    weak var presenter: ServerSelectionPresenting!
    
    //MARK: - Init
    required init(service: PingService) {
        self.service = service
    }
    
    //MARK: - Private -
    fileprivate var service: PingService
    fileprivate var request: CancellableRequest?
    
    //MARK: - Deinit
    deinit {
        request?.cancel()
    }
}

extension ServerSelectionInteractor: ServerSelectionInteracting {
    
    func ping(address: String) {
        guard let url = URL(string: address) else {
            presenter.present(R.string.localizable.serverAddressWrongFormat())
            return
        }
        guard (url.isValid(regex: URL.validIpAddressRegex) ||
            url.isValid(regex: URL.validHostnameRegex) ||
            url.isValid(regex: URL.validHttpIpAddressRegex)) else {
                presenter.present(R.string.localizable.serverAddressWrongFormat())
                return
        }
        let address = correctAddress(from: url)
        request = service.ping(address) { [weak self] result in
            switch result {
            case .success: self?.presenter.completeServerSelection()
            case .failure(let errorMessage): self?.presenter.present(errorMessage)
            }
        }
    }
    
    private func correctAddress(from url: URL) -> String {
        //TODO: Improve logic
        if url.isValid(regex: URL.validIpAddressRegex) {
            return "http://" + url.absoluteString
        }
        return url.absoluteString
    }
    
}

enum PingResult {
    case success, failure(String)
}

typealias PingCompletion = (PingResult) -> ()

protocol PingService {
    func ping(_ address: String, completion: @escaping PingCompletion) -> CancellableRequest
}
