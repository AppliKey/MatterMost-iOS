//
//  ControllersFactory.swift
//  ToolkitSources
//
//  Created by Smetankin Dmitry on 10/16/16.
//  Copyright © 2016 Smetankin Dmitry. All rights reserved.
//
import UIKit

fileprivate let rootTransitionDuration = 0.3
fileprivate let animationScaleFactor: CGFloat = 1.5

class NavigationManager {
    class func setRootController(_ rootController: UIViewController?) {
        guard let controller = rootController else {
            return
        }
        
        guard let currentRootController = self.windowRootController() else {
            setWindowRootController(controller)
            return
        }
        
        let snapshotView = currentRootController.view.snapshotView(afterScreenUpdates: false)
        if let view = controller.view,
            let snapshot = snapshotView {
            view.addSubview(snapshot)
        }
        
        setWindowRootController(controller)
        
        UIView.animate(withDuration: rootTransitionDuration, animations: { () -> Void in
            snapshotView?.layer.opacity = 0;
            snapshotView?.layer.transform = CATransform3DMakeScale(animationScaleFactor, animationScaleFactor, animationScaleFactor)
        }, completion: { (finished) -> Void in
            snapshotView?.removeFromSuperview()
        })
    }
    
    fileprivate class func setWindowRootController(_ rootController: UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController = rootController
    }
    
    fileprivate class func windowRootController() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
}
