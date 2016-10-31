//
//  SignInSignInViewController.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 31/10/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class SignInViewController: UIViewController, BaseView {
	
	//MARK: Properties
  	var eventHandler: SignInEventHandling!
    //MARK: Outlets
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nextButton: GradientButton!
    @IBOutlet weak var forgotPassButton: UIButton!
    
  
  	//MARK: Life cycle
	override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
	}
    
    //MARK: Actions
    @IBAction func nextButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func forgotPassButtonPressed(_ sender: AnyObject) {
    }

}

extension SignInViewController: SignInViewing {
}
