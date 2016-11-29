//
//  AlertShowing.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/11/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol AlertShowable: class {
    func alert(_ message: String)
    func alert(_ message: String, completion: VoidClosure?)
}

extension AlertShowable where Self: UIViewController {
    
    func alert(_ message: String) {
        alert(message, completion: nil)
    }
    
    func alert(_ message: String, completion: VoidClosure?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.okAlertTitle(),
                                      style: .default) { _ in
                                        completion?()
        })
        self.present(alert, animated: true, completion: nil)
    }
    
}
