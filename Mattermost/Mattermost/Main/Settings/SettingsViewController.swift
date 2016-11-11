//
//  SettingsSettingsViewController.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 11/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
	
	//MARK: - Properties
  	var eventHandler: SettingsEventHandling!
    
    //MARK: - Outlets
    
    @IBOutlet fileprivate weak var editProfileButton: UIButton!
    @IBOutlet fileprivate weak var logoutButton: UIButton!
    @IBOutlet fileprivate weak var unreadSwitcher: UISwitch!
    @IBOutlet fileprivate weak var unreadMessagesLabel: UILabel!
    
  	//MARK: - Life cycle

	override func viewDidLoad() {
		super.viewDidLoad()
        configureInterface()
        eventHandler.viewIsReady()
	}
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        eventHandler.viewWillDissapear()
    }

	//MARK: - Private -
    
	//MARK: - UI
    
    private func configureInterface() {
        localizeViews()
    }
    
    private func localizeViews() {
    }
    
    //MARK: - Actions

    @IBAction func switcherValueChanged(_ sender: Any) {
        eventHandler.handleSwitcherValueChanged(unreadSwitcher.isOn)
    }
}

extension SettingsViewController: SettingsViewing {
    
    func setUnreadSwitcher(withValue value:Bool) {
        unreadSwitcher.isOn = value
    }
    
}
