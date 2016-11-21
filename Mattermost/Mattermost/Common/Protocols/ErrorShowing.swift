//
//  ErrorShowing.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/11/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

protocol ErrorShowable: class {
    func alert(_ message: String)
}

extension ErrorShowable where Self: UIViewController {
    func alert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.okAlertTitle(),
                                      style: .default,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
