//
//  AppRouter.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 10/16/16.
//  Copyright © 2016 Smetankin Dmitry. All rights reserved.
//
import UIKit



class AppRouter {
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func setRootController(_ viewController: UIViewController?) {
        guard let controller = viewController else { return }
        guard let currentRootController = window.rootViewController else {
            window.rootViewController = controller
            return
        }
        
        let snapshotView = currentRootController.view.snapshotView(afterScreenUpdates: false)
        if let view = controller.view,
            let snapshot = snapshotView {
            view.addSubview(snapshot)
        }
        
        window.rootViewController = controller
        
        UIView.animate(withDuration: rootTransitionDuration, animations: {
            snapshotView?.layer.opacity = 0;
            snapshotView?.layer.transform = CATransform3DMakeScale(self.animationScaleFactor,
                                                                   self.animationScaleFactor,
                                                                   self.animationScaleFactor)
        }, completion: { finished in
            snapshotView?.removeFromSuperview()
        })
    }
    
    //MARK: - Private -
    private let window: UIWindow
    private let rootTransitionDuration = 0.3
    private let animationScaleFactor: CGFloat = 1.5
    
}
