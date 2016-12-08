//
//  InverseTableView.swift
//  Mattermost
//
//  Created by iOS_Developer on 08.12.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class InverseTableView: UITableView {
    
    private let myTransform = CGAffineTransform(scaleX: 1, y: -1)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        configure()
    }
    
    private func configure() {
        transform = myTransform
    }
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        let cell = super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.transform = myTransform
        return cell
    }

}
