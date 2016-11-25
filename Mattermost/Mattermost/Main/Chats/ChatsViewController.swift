//
//  ChatsChatsViewController.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 16/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class ChatsViewController: UIViewController {
	
	//MARK: - Properties
    
  	var eventHandler: ChatsEventHandling!
    @IBOutlet fileprivate weak var tableView: UITableView!
    fileprivate var chats = [ChatRepresentationModel]()
    var chatsService:ChatsService!

  	//MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.icMenu(), style: .done,
                                                           target: self, action: #selector(openMenuPressed(_:)))
        configureInterface()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        eventHandler.refresh()
    }
    
    //MARK: -
    
    func openMenuPressed(_ sender:AnyObject) {
        eventHandler.openMenu()
    }

	//MARK: - Private -
    
    private func configureInterface() {
        localizeViews()
        tableView.register(R.nib.singleChatCell)
        tableView.register(R.nib.groupChatCell)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func localizeViews() {
    }

	//MARK: - UI
    
    func refresh(_ sender: UIRefreshControl) {
        eventHandler.refresh()
    }

}

extension ChatsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatViewModel = chats[indexPath.row]
        var cell: ChannelCellViewing
        if chatViewModel.isDirectChat {
            cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.singleChatCell, for: indexPath)!
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.groupChatCell, for: indexPath)!
        }
        cell.configure(for: chatViewModel)
        cell.requests = eventHandler.handleCellAppearing(at: indexPath.row).flatMap{$0}
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
}

extension ChatsViewController: ChatsViewing {
    
    func updateView(with chatsRepresentation: [ChatRepresentationModel]) {
        chats = chatsRepresentation
        tableView.reloadData()
    }
    
    func showActivityIndicator() {
        tableView.refreshControl?.beginRefreshing()
    }
    
    func hideActivityIndicator() {
        tableView.refreshControl?.endRefreshing()
    }
    
    func updateCell(at index:Int, with model:ChatRepresentationModel) {
        let indexPath = IndexPath(row: index, section: 0)
        chats[index] = model
        if let cell = self.tableView.cellForRow(at: indexPath) as? ChannelCellViewing {
            cell.configure(for: model)
        }
    }
    
}
