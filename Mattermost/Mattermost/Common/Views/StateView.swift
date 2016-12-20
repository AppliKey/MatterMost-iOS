//
//  StateView.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 12/19/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

class StateView: UIView {
    //MARK: - Outlets
    @IBOutlet weak var icon: UIImageView?
    @IBOutlet weak var label: UILabel?
    
    var state: ActiveState = .active {
        didSet {
            icon?.tintColor = state.color
            label?.textColor = state.color
        }
    }

}

enum ActiveState {
    case active, inactive
    
    var color: UIColor {
        switch self {
        case .active: return UIColor.active
        case .inactive: return UIColor.inactive
        }
    }
}
