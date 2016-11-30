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
        navigationItem.title = R.string.localizable.settingsTitle()
        editProfileButton.setTitle(R.string.localizable.settingsEditProfile(), for: .normal)
        logoutButton.setTitle(R.string.localizable.settingsLogout(), for: .normal)
        unreadMessagesLabel.text = R.string.localizable.settingsUnreadMessages()
    }
    
    //MARK: - Actions

    @IBAction func switcherValueChanged(_ sender: Any) {
        eventHandler.handleSwitcherValueChanged(unreadSwitcher.isOn)
    }
    
    @IBAction func editProfileTapped(_ sender: Any) {
        eventHandler.handleEditProfile()
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        showLogoutAlert()
    }
    
    func showLogoutAlert() {
        let alert = UIAlertController(title: nil, message: R.string.localizable.settingsLogoutAlertMessage(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.yesAlertTitle(),
                                      style: .default) { [unowned self] _ in
                                        self.eventHandler.handleLogout()
        })
        alert.addAction(UIAlertAction(title: R.string.localizable.noAlertTitle(),
                                      style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

extension SettingsViewController: SettingsViewing {
    
    func setUnreadSwitcher(withValue value:Bool) {
        unreadSwitcher.isOn = value
    }
    
}
