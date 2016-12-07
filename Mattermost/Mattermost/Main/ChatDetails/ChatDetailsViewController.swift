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
        textViewHandler.maximumNumberOfLines = 6
        tableView.tableFooterView = UIView()
        tableView.register(R.nib.myMessagesCell)
    }
    
    private func localizeViews() {
    }

}

extension ChatDetailsViewController: ChatDetailsViewing {
    
    func addMorePosts(_ posts: [PostRepresentationModel]) {
        self.posts.append(contentsOf: posts)
        tableView.reloadData()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.myMessagesCell, for: indexPath)
            else { fatalError("Can not load myMessagesCell from nib") }
        
        cell.messageLabel.text = posts[indexPath.row].message
        
        return cell
    }
    
}

extension ChatDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = posts[indexPath.row]
        let textHieght = heightHelper.getheight(forString: model.message ?? "",
                                                withConstrainedWidth: 256, font: AppFonts.avenirNext())
        return textHieght + 24
    }
}
