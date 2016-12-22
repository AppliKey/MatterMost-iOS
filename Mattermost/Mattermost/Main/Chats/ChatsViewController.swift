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

  	//MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.icMenu(),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(openMenuPressed(_:)))
        configureInterface()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        eventHandler.viewIsReady()
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
        tableView.tableFooterView = UIView()
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
            cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.singleChatCell,
                                                 for: indexPath)!
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.groupChatCell,
                                                 for: indexPath)!
        }
        cell.configure(for: chatViewModel)
        cell.requests = eventHandler.handleCellAppearing(at: indexPath.row).flatMap{$0}
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventHandler.handleRowSelection(at: indexPath.row)
    }
    
}

extension ChatsViewController: ChatsViewing {
    
    func updateTabBarItem(for mode: ChatsMode, isUnread: Bool) {
        switch mode {
        case .unread:
            tabBarItem = UITabBarItem.withoutTitle(image: R.image.ic_unread_not_active(),
                                                   selectedImage: R.image.ic_unread())
        case .favourites:
            let image = isUnread ? R.image.ic_favorites_new() : R.image.ic_favorites_not_active()
            tabBarItem = UITabBarItem.withoutTitle(image: image,
                                                   selectedImage: R.image.ic_favorites())
        case .publicChats:
            let image = isUnread ? R.image.ic_public_chanels_new() : R.image.ic_public_chanels_not_active()
            tabBarItem = UITabBarItem.withoutTitle(image: image,
                                                   selectedImage: R.image.ic_public_chanels())
        case .privateChats:
            let image = isUnread ? R.image.ic_private_chanels_new() : R.image.ic_private_chanels_not_active()
            tabBarItem = UITabBarItem.withoutTitle(image: image,
                                                   selectedImage: R.image.ic_private_chanels())
        case .direct:
            let image = isUnread ? R.image.ic_direct_new() : R.image.ic_direct_not_active()
            tabBarItem = UITabBarItem.withoutTitle(image: image, selectedImage: R.image.ic_direct())
        }
    }
    
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
    
    func updateCell(at index: Int, with model: ChatRepresentationModel) {
        let indexPath = IndexPath(row: index, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as? ChannelCellViewing {
            chats[index] = model
            cell.configure(for: model)
        }
    }
    
    func moveToTop(channel: ChatRepresentationModel, fromIndex index: Int) {
        chats.remove(at: index)
        chats.insert(channel, at: 0)
        let oldIndexPath = IndexPath(row: index, section: 0)
        let newIndexPath = IndexPath(row: 0, section: 0)
        tableView.beginUpdates()
        tableView.moveRow(at: oldIndexPath, to: newIndexPath)
        tableView.endUpdates()
        if let cell = tableView.cellForRow(at: newIndexPath) as? ChannelCellViewing {
            cell.configure(for: channel)
        }
    }
}
