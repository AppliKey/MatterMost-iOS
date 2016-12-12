//
//  ChatDetailsChatDetailsViewController.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 01/12/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit
import GrowingTextViewHandler_Swift

class ChatDetailsViewController: UIViewController {
	
	//MARK: - Properties
    
  	var eventHandler: ChatDetailsEventHandling!
    fileprivate var textViewHandler: GrowingTextViewHandler!
    fileprivate var posts: [PostRepresentationModel] = []
    fileprivate var heightHelper = HeightProcessor()
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var messageTextViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var quotationViewHeightConstraint: NSLayoutConstraint!
    
  	//MARK: - Life cycle

	override func viewDidLoad() {
		super.viewDidLoad()
        configureInterface()
        eventHandler.viewIsReady()
	}

	//MARK: - Private -

	//MARK: - UI
    
    private func configureInterface() {
        localizeViews()
        messageTextView.delegate = self
        textViewHandler = GrowingTextViewHandler(textView: messageTextView, heightConstraint: messageTextViewHeightConstraint)
        textViewHandler.minimumNumberOfLines = 1
        textViewHandler.maximumNumberOfLines = 5
        tableView.tableFooterView = UIView()
        tableView.register(R.nib.myMessagesCell)
        tableView.register(R.nib.groupMessageCell)
        tableView.register(R.nib.directMessageCell)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func localizeViews() {
    }
    
    func refresh(_ sender: UIRefreshControl) {
        eventHandler.refresh()
    }

    @IBAction func attachButtonPressed(_ sender: Any) {
        eventHandler.handleAttachPressed()
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        eventHandler.handleSendMessage(messageTextView.text)
    }
}

extension ChatDetailsViewController: ChatDetailsViewing {
    
    func insert(post:PostRepresentationModel) {
        self.posts.insert(post, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .top)
        tableView.endUpdates()
    }
    
    func refreshData(withPosts posts: [PostRepresentationModel]) {
        self.posts = posts
        tableView.reloadData()
    }
    
    func addMorePosts(_ posts: [PostRepresentationModel]) {
        self.posts.append(contentsOf: posts)
        tableView.reloadData()
    }
    
    func showActivityIndicator() {
        tableView.refreshControl?.beginRefreshing()
    }
    
    func hideActivityIndicator() {
        tableView.refreshControl?.endRefreshing()
    }
    
}

extension ChatDetailsViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textViewHandler.resizeTextView(false)
    }
}

extension ChatDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:MessageCellViewing!
        let postRepresentation = posts[indexPath.row]
        if postRepresentation.isMyMessage {
            cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.myMessagesCell, for: indexPath)
        } else {
            if postRepresentation.isDirectChat || !postRepresentation.showAvatar {
                cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.directMessageCell, for: indexPath)
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.groupMessageCell, for: indexPath)
            }
        }
        cell.configure(withRepresentationModel: postRepresentation)
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == posts.count - 1 {
            eventHandler.handlePagination()
        }
    }
    
}

private let margins: CGFloat = 24
private let topViewHeight: CGFloat = 40
private let bottomViewHeight: CGFloat = 30
private let avatarHeight: CGFloat = 33
private let maxMessageWidth: CGFloat = 200

extension ChatDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = posts[indexPath.row]
        var elementsHeight = heightHelper.getheight(forString: model.message ?? "",
                                                    withConstrainedWidth: maxMessageWidth, font: AppFonts.avenirNext())
        if model.showTopView {
            elementsHeight += topViewHeight
        }
        if model.showBottomView {
            elementsHeight += bottomViewHeight
        }
        if !model.isMyMessage && !model.isDirectChat && model.showAvatar {
            elementsHeight += avatarHeight
        }
        return elementsHeight + margins
    }
}
