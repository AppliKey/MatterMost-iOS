//
//  ForgotPassForgotPassViewController.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class ForgotPassViewController: UIViewController, ActivityIndicatorHolder {
	
	//MARK: - Properties
  	var eventHandler: ForgotPassEventHandling!
    //MARK: - Outlets
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButton: GradientButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
  	//MARK: - Life cycle

	override func viewDidLoad() {
		super.viewDidLoad()
        configureInterface()
	}
    
    //MARK: - Actions
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        eventHandler.send(email)
    }

    //MARK: - Private -
    private var keyboardHandler: KeyboardHandler?
    private var tapRecognizer: HideKeyboardRecognizer?
    private var email: String {
        return emailTextField.text ?? ""
    }

	//MARK: - UI
    
    private func configureInterface() {
        localizeViews()
        setupKeyboardHandler()
        tapRecognizer = HideKeyboardRecognizer(withView: view)
        emailTextField.delegate = self
    }
    
    private func localizeViews() {
        emailLabel.text = R.string.localizable.emailFieldHint()
        emailTextField.placeholder = R.string.localizable.emailFieldPlaceholder()
        sendButton.setTitle(R.string.localizable.sendButtonTitle(), for: UIControlState.normal)
    }
    
    private func setupKeyboardHandler() {
        guard let emailView = emailTextField.superview else { return }
        keyboardHandler = KeyboardHandler(withView: emailView)
    }

}

extension ForgotPassViewController: ForgotPassViewing {
}

extension ForgotPassViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === emailTextField {
            sendButtonPressed(sendButton)
        }
        return true
    }
}
