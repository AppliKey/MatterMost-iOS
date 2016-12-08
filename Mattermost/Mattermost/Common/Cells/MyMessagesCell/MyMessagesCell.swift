//
//  MyMessagesCell.swift
//  Mattermost
//
//  Created by iOS_Developer on 07.12.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

fileprivate let dateBackgrpundColor = UIColor(rgba: "#64b0ff")
fileprivate let newMessageBackgroundColor = UIColor(rgba: "#c9cdd4")

enum TopViewMode {
    case date
    case newMessage
}

class MyMessagesCell: UITableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        isLongDateFormatActive = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageLabel.font = AppFonts.avenirNext()
    }
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet private weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var bottomViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet private weak var bottomLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    
    private var isLongDateFormatActive: Bool = false
    
    @IBAction private func bottomViewTapped(_ sender: Any) {
        isLongDateFormatActive = !isLongDateFormatActive
        if let date = date {
            bottomLabel.text = isLongDateFormatActive ? DateHelper.fullDateTimeString(forDate: date)
                                                      : DateHelper.time(forDate: date)
        }
    }
    
    var date:Date? {
        didSet {
            if let date = date {
                bottomLabel.text = DateHelper.time(forDate: date)
            }
        }
    }
    
    var isTopViewHidden: Bool = true {
        didSet {
            topViewHeightConstraint.constant = isTopViewHidden ? 0 : 40
        }
    }
    
    var isBottomViewHidden: Bool = false {
        didSet {
            bottomViewHeightConstraint.constant = isBottomViewHidden ? 0 : 30
        }
    }
    
    var topViewMode:TopViewMode = TopViewMode.date {
        didSet {
            switch topViewMode {
            case .date:
                topView.backgroundColor = dateBackgrpundColor
            default:
                topView.backgroundColor = newMessageBackgroundColor
            }
        }
    }
    
}
