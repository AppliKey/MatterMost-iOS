//
//  ActivityIndication.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/11/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol ActivityIndicating {
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol ActivityIndicatorHolder {
    weak var activityIndicator: UIActivityIndicatorView? {get set}
}

extension ActivityIndicatorHolder where Self: ActivityIndicating {
    
    func showActivityIndicator() {
        activityIndicator?.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator?.stopAnimating()
    }
    
}
