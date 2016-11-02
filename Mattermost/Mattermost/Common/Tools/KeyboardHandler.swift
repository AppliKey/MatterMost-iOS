//
//  KeyboardManager.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/2/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit
import Typist

class KeyboardHandler {
    
    func start() {
        if !isEnabled {
            isEnabled = true
            keyboard.start()
        }
    }
    
    func stop() {
        isEnabled = false
        keyboard.stop()
    }

    //MARK: Init
    required init(withViews views: [UIView], superview: UIView) {
        self.views = views
        self.superview = superview
        setupKeyboard()
    }
    
    //MARK: Private
    private let views: [UIView]
    let superview: UIView
    private let keyboard = Typist()
    private var isEnabled = true
    private var keyboardHeight: CGFloat = 0
    private var keyboardHeightDifference: CGFloat = 0
    private var animationDuration = 0.5
    
    private func setupKeyboard() {
        keyboard
            .on(event: .willShow) { [unowned self] options in
                self.handleKeyboardChangeWithOptions(options)
            }
            .on(event: .willHide) { [unowned self] options in
                self.handleKeyboardChangeWithOptions(options)
            }
            .start()
    }
    
    private func handleKeyboardChangeWithOptions(_ options: Typist.KeyboardOptions) {
        keyboardHeightDifference = options.startFrame.origin.y
            - options.endFrame.origin.y
        keyboardHeight = options.endFrame.size.height
        animationDuration = options.animationDuration
        updateViews()
    }
    
    private func updateViews() {
        guard isEnabled else { return }
        guard views.count > 0 else { return }
        superview.layoutIfNeeded()
        for view in views {
            if let scrollView = view as? UIScrollView {
                updateInsetForScrollView(scrollView)
            } else {
                updateConstraintsForView(view)
            }
        }
        UIView.animate(withDuration: animationDuration) {
            self.superview.layoutIfNeeded()
        }
    }
    
    private func updateInsetForScrollView(_ scrollView: UIScrollView) {
        var inset = scrollView.contentInset
        inset.bottom += keyboardOverlayHeightForView(scrollView, modificator: inset.bottom)
        scrollView.contentInset = inset
        showFirstResponderInScrollView(scrollView)
    }
    
    private func showFirstResponderInScrollView(_ scrollView: UIScrollView) {
        if let firstResponder = UIResponder.firstResponder() as? UIView,
            firstResponder.isDescendant(of: scrollView) {
            let frame = scrollView.convert(firstResponder.frame, from: firstResponder.superview)
            scrollView.scrollRectToVisible(frame, animated: true)
        }
    }
    
    private func updateConstraintsForView(_ view: UIView) {
        guard let constraint = view.firstBottomConstraint() else { return }
        constraint.constant += keyboardOverlayHeightForView(view, modificator: constraint.constant)
    }
    
    private func keyboardOverlayHeightForView(_ view: UIView, modificator: CGFloat) -> CGFloat {
        if keyboardHeight > fabs(keyboardHeightDifference) {
            return keyboardHeightDifference
        }
        let viewFrame = superview.convert(view.frame, from: view.superview)
        let bottomOffset = superview.frame.size.height - viewFrame.origin.y
            - viewFrame.size.height - modificator
        if keyboardHeightDifference < 0 {
            return keyboardHeightDifference + bottomOffset
        } else {
            return keyboardHeightDifference - bottomOffset
        }
    }
    
}
