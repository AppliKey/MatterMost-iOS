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
    
    struct ManagedView {
        let view: UIView
        let offset: CGFloat
        
        //MARK: - Init
        
        init(_ view: UIView, withOffset offset: CGFloat = defaultOffset) {
            self.view = view
            self.offset = offset
            bottomConstraint = bottomConstraintFor(view)
        }
        
        //MARK: - Private -
        fileprivate let bottomConstraint: CGFloat
        
    }
    
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
    convenience init(withViews views: [UIView]) {
        self.init(withManagedViews: views.map({ ManagedView($0) }))
    }
    
    convenience init(withView view: UIView, offset: CGFloat = defaultOffset) {
        self.init(withManagedViews: [ManagedView(view, withOffset: offset)])
    }
    
    required init(withManagedViews managedViews: [ManagedView]) {
        self.managedViews = managedViews
        setupKeyboard()
    }
    
    //MARK: Private
    private let managedViews: [ManagedView]
    private let keyboard = Typist()
    private var isEnabled = true
    private var keyboardHeightDifference: CGFloat = 0
    private var animationDuration = 0.5
    private var keyboardFrame: CGRect = .zero
    
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
        animationDuration = options.animationDuration
        keyboardFrame = options.endFrame
        updateViews()
    }
    
    private func updateViews() {
        guard isEnabled else { return }
        guard keyboardHeightDifference != 0 else { return }
        guard managedViews.count > 0 else { return }
        for managedView in managedViews {
            if managedView.view is UIScrollView {
                updateBottomInsetFor(managedView)
            } else {
                updateBottomConstraintFor(managedView)
            }
        }
    }
    
    private func updateBottomInsetFor(_ managedView: ManagedView) {
        guard let scrollView = managedView.view as? UIScrollView else { return }
        var inset = scrollView.contentInset
        inset.bottom = newBottomConstraintFor(managedView)
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
    
    private func updateBottomConstraintFor(_ managedView: ManagedView) {
        let view = managedView.view
        guard let constraint = view.firstBottomConstraint() else { return }
        constraint.constant = newBottomConstraintFor(managedView)
        UIView.animate(withDuration: animationDuration) {
            view.superview?.layoutIfNeeded()
        }
    }
    
    private func newBottomConstraintFor(_ managedView: ManagedView) -> CGFloat {
        if self.keyboardFrame.height > fabs(keyboardHeightDifference) {
            return bottomConstraintFor(managedView.view) + keyboardHeightDifference
        }
        if keyboardHeightDifference < 0 {
            return managedView.bottomConstraint
        }
        let view = managedView.view
        guard let window = view.window else { return 0 }
        let viewFrame = window.convert(view.frame, from: nil)
        let keyboardFrame = window.convert(self.keyboardFrame, from: nil)
        let bottomOffset = window.frame.height - viewFrame.origin.y - viewFrame.height
        let constraint = keyboardFrame.height - bottomOffset + managedView.offset + managedView.bottomConstraint
        return constraint
    }
    
}

fileprivate let defaultOffset: CGFloat = 20

fileprivate func bottomConstraintFor(_ view: UIView) -> CGFloat {
    if let scrollView = view as? UIScrollView {
        return scrollView.contentInset.bottom
    } else {
        return view.firstBottomConstraint()?.constant ?? 0
    }
}
