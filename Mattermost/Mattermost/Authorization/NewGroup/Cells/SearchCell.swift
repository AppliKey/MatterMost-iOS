//
//  SearchCell.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 12/28/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell, NibReusable {
    //MARK: - Outlets
    @IBOutlet weak var searchTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        localizeViews()
    }
    
    private func localizeViews() {
        searchTextField.placeholder = R.string.localizable.searchPlaceholder()
    }
    
}
