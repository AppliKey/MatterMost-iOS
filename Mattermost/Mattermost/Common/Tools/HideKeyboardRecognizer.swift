//
//  HideKeyboardRecognizer.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/2/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class HideKeyboardRecognizer {
    
    //MARK: - Init
    required init(withView view: UIView) {
        self.view = view
        setupGestureRecognizer()
    }
    
    //MARK: - Private -
    private unowned let view: UIView
    private var tapRecognizer: UITapGestureRecognizer?
    
    //MARK: - Gesture recognizer
    
    private func setupGestureRecognizer() {
        let action = #selector(HideKeyboardRecognizer.hideKeyboard)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: action)
        view.addGestureRecognizer(tapRecognizer)
        self.tapRecognizer = tapRecognizer
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
}
