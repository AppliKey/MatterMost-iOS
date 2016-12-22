//
//  NewGroupTypeCell.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 12/19/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class NewGroupTypeCell: UITableViewCell, NibReusable {
    
    var typeChange: ((GroupType) -> Void)?
    var type: GroupType {
        set {
            typeSwitch.isOn = type == .private
            update()
        }
        get {
            return typeSwitch.isOn ? .private : .public
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        update()
        localizeViews()
    }
    
    //MARK: - IBAction
    @IBAction func typeSwitchValueChanged(_ sender: UISwitch) {
        typeChange?(type)
        update()
    }
    
    //MARK: - Privite -
    @IBOutlet private weak var publicStateView: StateView!
    @IBOutlet private weak var privateStateView: StateView!
    @IBOutlet private weak var typeSwitch: UISwitch!
    
    private func update() {
        publicStateView.state = type == .public ? .active : .inactive
        privateStateView.state = type == .private ? .active : .inactive
    }
    
    private func localizeViews() {
        publicStateView.label?.text = R.string.localizable.publicTypeLabel()
        privateStateView.label?.text = R.string.localizable.privateTypeLabel()
    }
    
}
