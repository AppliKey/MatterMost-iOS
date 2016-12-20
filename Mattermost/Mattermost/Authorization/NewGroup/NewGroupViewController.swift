//
//  NewGroupNewGroupViewController.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 19/12/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class NewGroupViewController: UIViewController {
	
	//MARK: - Properties
  	var eventHandler: NewGroupEventHandling!
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
  
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
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: NewGroupTypeCell.self)
    }

}

extension NewGroupViewController: NewGroupViewing {
}

extension NewGroupViewController: UITableViewDataSource {
    
    fileprivate enum sections: Int {
        case groupInfo, membersInfo, users
        static let count = 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = sections(rawValue: section) else { return 0 }
        switch section {
        case .groupInfo: return 4
        case .membersInfo: return 2
        case .users: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

extension NewGroupViewController: UITableViewDelegate {
    
}
