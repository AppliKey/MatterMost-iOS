//
//  NewGroupTextCell.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 12/21/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

class NewGroupTextCell: UITableViewCell, NibReusable {
    
    //MARK: - Outlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textView: RSKPlaceholderTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTextView()
    }
    
    class func heightForText(_ text: String, withViewWidth viewWidth: CGFloat) -> CGFloat {
        let width = viewWidth - 2.0 * Constants.textViewHorizontalOffset
            - 2.0 * Constants.lineFragmentPadding
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingRect = text.boundingRect(with: size,
                                             options: [.usesLineFragmentOrigin, .usesFontLeading],
                                             attributes: [NSFontAttributeName: Constants.textViewFont],
                                             context: nil)
        let textViewHeight = boundingRect.height + Constants.textContainerInset.top
            + Constants.textContainerInset.bottom
        let cellHeight = textViewHeight + Constants.textViewVerticalOffset
        return cellHeight
    }
    
    //MARK: - Private -
    
    private func configureTextView() {
        textView.textContainerInset = Constants.textContainerInset
        textView.textContainer.lineFragmentPadding = Constants.lineFragmentPadding
        textView.font = Constants.textViewFont
    }
    
}

fileprivate enum Constants {
    static let textContainerInset = UIEdgeInsets.zero
    static let lineFragmentPadding = CGFloat(0)
    static let textViewHorizontalOffset = CGFloat(30)
    static let textViewVerticalOffset = CGFloat(30 + 20 + 15 + 15)
    static let textViewFont = UIFont.mainFontOfSize(18)
}
