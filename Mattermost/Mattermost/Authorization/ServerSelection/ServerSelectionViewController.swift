//
//  ServerSelectionServerSelectionViewController.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 27/10/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit
import Rswift

class ServerSelectionViewController: UIViewController, ActivityIndicatorHolder {
    //MARK: - Properties
    var eventHandler: ServerSelectionEventHandling!
    //MARK: - Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var serverTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInterface()
        //serverTextField.text = "https://mattermost-nutscracker53.herokuapp.com"
    }
    
    //MARK: - Actions
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if let address = serverTextField.text {
            eventHandler.handleServerAddress(address: address)
        }
    }
    
    //MARK: - Private -
    private var keyboardHandler: KeyboardHandler?
    private var tapRecognizer: HideKeyboardRecognizer?
    
    //MARK: - UI
    
    private func configureInterface() {
        localizeViews()
        serverTextField.delegate = self
        tapRecognizer = HideKeyboardRecognizer(withView: view)
        setupKeyboardHandler()
    }
    
    private func localizeViews() {
        headerLabel.text = R.string.localizable.welcome()
        descriptionLabel.text = R.string.localizable.description()
        hintLabel.text = R.string.localizable.serverFieldHint()
        serverTextField.placeholder = R.string.localizable.serverFieldPlaceholder()
        nextButton.setTitle(R.string.localizable.nextButtonTitle(), for: .normal)
    }
    
    private func setupKeyboardHandler() {
        guard let passwordView = serverTextField.superview else { return }
        keyboardHandler = KeyboardHandler(withView: passwordView)
    }
}

//MARK: - ServerSelectionViewing
extension ServerSelectionViewController: ServerSelectionViewing {
}

//MARK: - UITextFieldDelegate
extension ServerSelectionViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let resultString = NSString(string: currentText).replacingCharacters(in: range, with: string)
        nextButton.isEnabled = !resultString.isEmpty
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === serverTextField {
            view.endEditing(true)
            nextButtonPressed(nextButton)
        }
        return true
    }
    
}

