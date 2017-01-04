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
    private var keyboardHandler: KeyboardHandler?
    
    @IBOutlet weak var replyTextLabel: UILabel!
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        eventHandler.handleBack()
    }

	//MARK: - Private -

	//MARK: - UI
    
    private func configureInterface() {
        localizeViews()
        setupKeyboardHandler()
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
    
    @IBAction func closeReplyPressed(_ sender: Any) {
        eventHandler.handleCloseReply()
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        guard messageTextView.text.characters.count > 0
            else {return}
        eventHandler.handleSendMessage(messageTextView.text)
        messageTextView.text = ""
        textViewHandler.resizeTextView(false)
    }
    
    fileprivate func checkUpdatedPost(atIndex index:Int) {
        guard posts.count > index + 1
            else { return }
        tableView.beginUpdates()
        posts[index].showTopView = PostRepresentationModel.showTopView(forPost: posts[index],
                                                                       previousPost: posts[index + 1])
        posts[index + 1].showBottomView = PostRepresentationModel.showBottomView(forPost: posts[index + 1],
                                                                                 previousPost: posts[index])
        let indexPath = IndexPath(row: index, section: 0)
        let nextRow = IndexPath(row: index + 1, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as? MessageCellViewing {
            cell.configure(withRepresentationModel: posts[index])
        }
        if let nextCell = tableView.cellForRow(at: nextRow) as? MessageCellViewing {
            nextCell.configure(withRepresentationModel: posts[index + 1])
        }
        tableView.endUpdates()
    }
    
    private func setupKeyboardHandler() {
        guard let passwordView = messageTextView.superview else { return }
        keyboardHandler = KeyboardHandler(withView: passwordView, offset: 0)
    }
}

fileprivate let replyViewHeight:CGFloat = 56

extension ChatDetailsViewController: ChatDetailsViewing {
    
    func showReplyPost(_ post:PostRepresentationModel) {
        quotationViewHeightConstraint.constant = replyViewHeight
        replyTextLabel.text = post.message
    }
    
    func closeReply() {
        quotationViewHeightConstraint.constant = 0
        replyTextLabel.text = ""
    }
    
    func insert(post:PostRepresentationModel) {
        posts.insert(post, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .top)
        tableView.endUpdates()
        checkUpdatedPost(atIndex: 0)
    }
    
    func update(post: PostRepresentationModel) {
        if let index = posts.index(where: {$0.placeholderId == post.placeholderId}) {
            let indexPath = IndexPath(row: index, section: 0)
            posts[index] = post
            if let cell = tableView.cellForRow(at: indexPath) as? MessageCellViewing {
                cell.configure(withRepresentationModel: post)
            }
            checkUpdatedPost(atIndex: index)
        }
    }
    
    func showError(forPostWithPlaceholderId id:String) {
        if let index = posts.index(where: {$0.placeholderId == id}) {
            let indexPath = IndexPath(row: index, section: 0)
            posts[index].postStatus = .failed
            if let cell = tableView.cellForRow(at: indexPath) as? MessageCellViewing {
                cell.configure(withRepresentationModel: posts[index])
            }
        }
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
            (cell as! MyMessagesCell).retryCallback = { [unowned self] in
                if let index = tableView.indexPath(for: cell as! UITableViewCell) {
                    let post = self.posts[index.row]
                    self.eventHandler.handleRetry(forPlaceholderPost: post)
                }
            }
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
private let replyMessageHeight: CGFloat = 32

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
        if let _ = model.replyMessage, let _ = model.replyMessageId {
            elementsHeight += replyMessageHeight
        }
        return elementsHeight + margins
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventHandler.handleReply(post: posts[indexPath.row])
    }
}
