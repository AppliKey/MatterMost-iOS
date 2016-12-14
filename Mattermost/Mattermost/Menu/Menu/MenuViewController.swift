//
//  MenuMenuViewController.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController {
	
	//MARK: - Properties
  	var eventHandler: MenuEventHandling!
    @IBOutlet weak var createGroupButton: UIButton!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
  	//MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureInterface()
        eventHandler.viewIsReady()
    }
    
	//MARK: - Private -
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    fileprivate var viewModel: MenuViewModel!

	//MARK: - UI
    
    private func configureInterface() {
        localizeViews()
        tableView.bounces = false
    }
    
    private func localizeViews() {
        createGroupButton.setTitle(R.string.localizable.newGroupChannel(), for: .normal)
    }

}

extension MenuViewController: MenuViewing {
    
    func updateView(withViewModel vm: MenuViewModel) {
        self.viewModel = vm
        userNameLabel.text = vm.userName
        teamNameLabel.text = vm.teamName
        if let avatarUrl = vm.avatarUrl {
            avatarImageView.setRoundedImage(withUrl: avatarUrl)
        } else {
            avatarImageView.image = R.image.placeholderSmall()
        }
        tableView.reloadData()
    }
    
}

extension MenuViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventHandler.handleRowSelection(withIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.labelCell, for: indexPath)!
        cell.label.text = viewModel.menuItems[indexPath.row]
        return cell
    }
    
}
