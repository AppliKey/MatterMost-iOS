//
//  ForgotPassForgotPassViewController.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class ForgotPassViewController: UIViewController {
	
	//MARK: - Properties
  	var eventHandler: ForgotPassEventHandling!
    //MARK: - Outlets
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButton: GradientButton!
    
  	//MARK: - Life cycle

	override func viewDidLoad() {
		super.viewDidLoad()
        configureInterface()
	}
    
    //MARK: - Actions
    @IBOutlet weak var sendButtonPressed: GradientButton!

	//MARK: - Private -

	//MARK: - UI
    
    private func configureInterface() {
        localizeViews()
    }
    
    private func localizeViews() {
    }

}

extension ForgotPassViewController: ForgotPassViewing {
}
