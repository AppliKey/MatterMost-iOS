//
//  SignInSignInViewController.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 31/10/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class SignInViewController: UIViewController, ActivityIndicatorHolder {
	
	//MARK: Properties
  	var eventHandler: SignInEventHandling!
    //MARK: Outlets
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nextButton: GradientButton!
    @IBOutlet weak var forgotPassButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
  
  	//MARK: Life cycle
    
	override func viewDidLoad() {
        super.viewDidLoad()
        configureInterface()
	}
    
    //MARK: Actions
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        eventHandler.next(withEmail: email, andPassword: password)
    }
    
    @IBAction func forgotPassButtonPressed(_ sender: AnyObject) {
        eventHandler.forgotPass(forEmail: email)
    }
    
    //MARK: - Private -
    private var keyboardHandler: KeyboardHandler?
    private var tapRecognizer: HideKeyboardRecognizer?
    private var email: String {
        return emailTextField.text ?? ""
    }
    private var password: String {
        return passwordTextField.text ?? ""
    }
    
    //MARK: - UI
    
    private func configureInterface() {
        localizeViews()
        setupKeyboardHandler()
        passwordTextField.delegate = self
        emailTextField.delegate = self
        tapRecognizer = HideKeyboardRecognizer(withView: view)
    }
    
    private func localizeViews() {
        emailLabel.text = R.string.localizable.emailFieldHint()
        passwordLabel.text = R.string.localizable.passwordFieldHint()
        emailTextField.placeholder = R.string.localizable.emailFieldPlaceholder()
        passwordTextField.placeholder = R.string.localizable.passwordFieldPlaceholder()
        nextButton.setTitle(R.string.localizable.nextButtonTitle(), for: .normal)
        forgotPassButton.setTitle(R.string.localizable.forgotPassword(), for: .normal)
    }
    
    private func setupKeyboardHandler() {
        guard let passwordView = passwordTextField.superview else { return }
        keyboardHandler = KeyboardHandler(withView: passwordView)
    }
    
    //MARK: - Error handling

}

//MARK: - SignInViewing
extension SignInViewController: SignInViewing {
    
    func show(_ error: SignInError) {
        switch error {
        case .email(let message):
            alert(message)
        case .password(let message):
            alert(message)
        case .other(let message):
            alert(message)
        }
    }
    
}

//MARK: - UITextFieldDelegate
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        if textField === passwordTextField {
            view.endEditing(true)
            nextButtonPressed(nextButton)
        }
        return true
    }
}
