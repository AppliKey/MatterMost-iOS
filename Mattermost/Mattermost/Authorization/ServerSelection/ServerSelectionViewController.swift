//
//  ServerSelectionServerSelectionViewController.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 27/10/2016.
//  Copyright © 2016 Vladimir Kravchenko. All rights reserved.
//

import Foundation
import UIKit

class ServerSelectionViewController: UIViewController, BaseView {
    var eventHandler: ServerSelectionEventHandler!
    //MARK: Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var serverTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureRecognizer()
    }
    
    //MARK: Actions
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
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
