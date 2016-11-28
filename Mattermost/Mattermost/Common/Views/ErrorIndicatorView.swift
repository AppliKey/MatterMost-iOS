//
//  ErrorIndicatorView.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/28/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

@IBDesignable
class ErrorIndicatorView: UIView {

    //MARK: - Properties
    
    @IBInspectable var normalColor: UIColor = .white{
        didSet { updateColor() }
    }
    @IBInspectable var errorColor: UIColor = .red{
        didSet { updateColor() }
    }
    @IBInspectable var isIndicating: Bool = false {
        didSet { updateColor() }
    }
    
    //MARK: Overrides
    
    override func awakeFromNib() {
        updateColor()
    }
    
    override func prepareForInterfaceBuilder() {
        updateColor()
    }
    
    //MARK: - Private
    
    func updateColor() {
        backgroundColor = isIndicating ? errorColor : normalColor
    }
    
}
