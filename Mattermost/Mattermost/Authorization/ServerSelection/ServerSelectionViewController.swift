//
//  ServerSelectionServerSelectionViewController.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 27/10/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class ServerSelectionViewController: UIViewController, BaseView {
    var eventHandler: ServerSelectionEventHandling!
    //MARK: Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var serverTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupGestureRecognizer()
        serverTextField.delegate = self
    }
    
    //MARK: Actions
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if let address = serverTextField.text {
            eventHandler.handleServerAddress(address: address)
        }
    }
    
    //MARK: Private
    private var tapRecognizer: UITapGestureRecognizer?
    
    private func setupGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(ServerSelectionViewController.hideKeyboard))
        view.addGestureRecognizer(recognizer)
        self.tapRecognizer = recognizer
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
}

extension ServerSelectionViewController: ServerSelectionViewing {
}

extension ServerSelectionViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let resultString = NSString(string: currentText).replacingCharacters(in: range, with: string)
        nextButton.isEnabled = !resultString.isEmpty
        return true
    }
    
}
