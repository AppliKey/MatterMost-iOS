//
//  NewGroupMembersNewGroupMembersViewController.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 19/12/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class NewGroupMembersViewController: UIViewController {
	
	//MARK: - Properties
  	var eventHandler: NewGroupMembersEventHandling!
  
  	//MARK: - Life cycle

	override func viewDidLoad() {
		super.viewDidLoad()
        configureInterface()
	}

	//MARK: - Private -

	//MARK: - UI
    
    private func configureInterface() {
        localizeViews()
    }
    
    private func localizeViews() {
    }

}

extension NewGroupMembersViewController: NewGroupMembersViewing {
}
