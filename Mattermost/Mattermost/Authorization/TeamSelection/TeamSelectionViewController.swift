//
//  TeamSelectionTeamSelectionViewController.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit
import Rswift

class TeamSelectionViewController: UIViewController {
	
	//MARK: - Properties
  	var eventHandler: TeamSelectionEventHandling!
    //MARK: - Outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
  
  	//MARK: - Life cycle

	override func viewDidLoad() {
		super.viewDidLoad()
        configureInterface()
        eventHandler.refresh()
	}

	//MARK: - Private -
    fileprivate var teams: [TeamRepresentation] = []

	//MARK: - UI
    
    private func configureInterface() {
        localizeViews()
        configureTableView()
    }
    
    private func localizeViews() {
        headerLabel.text = R.string.localizable.teamSelectionHeader()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(cellType: TeamCell.self)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.estimatedRowHeight = 70
    }
    
    func refresh(_ sender: UIRefreshControl) {
        eventHandler.refresh()
    }

}

extension TeamSelectionViewController: TeamSelectionViewing {
    func show(_ teams: [TeamRepresentation]) {
        self.teams = teams
        tableView?.reloadData()
    }
    
    func showActivityIndicator() {
        tableView.refreshControl?.beginRefreshing()
    }
    
    func hideActivityIndicator() {
        tableView.refreshControl?.endRefreshing()
    }
}

extension TeamSelectionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as TeamCell
        let team = teams[indexPath.row]
        cell.nameLabel.text = team.name
        return cell
    }
    
}

extension TeamSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let team = teams[indexPath.row]
        team.selection()
    }
}

struct TeamRepresentation {
    let name: String
    let selection: VoidClosure
}
