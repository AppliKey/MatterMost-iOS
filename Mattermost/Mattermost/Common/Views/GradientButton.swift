//
//  GradientButton.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 27.10.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

@IBDesignable
class GradientButton: UIButton {
    
    @IBInspectable var startColor: UIColor = .white {
        didSet { updateGradient() }
    }
    
    @IBInspectable var endColor: UIColor = .white {
        didSet { updateGradient() }
    }
    
    @IBInspectable var isHorizontal = true {
        didSet { updateGradient() }
    }
    
    //MARK: Overrides

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func prepareForInterfaceBuilder() {
        updateGradient()
    }
    
    //MARK: Private
    
    private func updateGradient() {
        guard let layer = layer as? CAGradientLayer else { return }
        layer.colors = [startColor.cgColor, endColor.cgColor]
        layer.locations = [0, 1]
        if (isHorizontal){
            layer.endPoint = CGPoint(x: 1, y: 0)
        }else{
            layer.endPoint = CGPoint(x: 0, y: 1)
        }
        self.setNeedsDisplay()
    }

}
