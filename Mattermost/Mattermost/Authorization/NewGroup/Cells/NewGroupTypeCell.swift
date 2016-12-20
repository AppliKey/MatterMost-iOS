//
//  NewGroupTypeCell.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 12/19/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class NewGroupTypeCell: UITableViewCell, NibReusable {
    
    //MARK: - Outlets
    @IBOutlet weak var publicStateView: StateView!
    @IBOutlet weak var privateStateView: StateView!
    @IBOutlet weak var typeSwitch: UISwitch!
    
    override func awakeFromNib() {
        update()
    }
    
    //MARK: - IBAction
    @IBAction func typeSwitchValueChanged(_ sender: UISwitch) {
        update()
    }
    
    //MARK: - Privite 
    
    private func update() {
        let isPrivate = typeSwitch.isOn
        publicStateView.state = isPrivate ? .inactive : .active
        privateStateView.state = isPrivate ? .active : .inactive
    }
    
}
