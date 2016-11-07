//
//  TabBarTabBarViewController.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
	
	//MARK: - Properties
  	var eventHandler: TabBarEventHandling!
  
  	//MARK: - Life cycle

	override func viewDidLoad() {
		super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.icMenu(), style: .done,
                                                                                 target: self, action: #selector(openMenuPressed))
        configureInterface()
        eventHandler.viewIsReady()
        configureNavigationBar()
	}
    
    //MARK: -
    
    func openMenuPressed() {
        
    }

	//MARK: - Private -

	//MARK: - UI
    
    private func configureInterface() {
        localizeViews()
        configureTabBar()
    }
    
    private func localizeViews() {
    }
    
    private func configureTabBar() {
        tabBar.barTintColor = UIColor.white
        for tabBarItem in tabBar.items! {
            tabBarItem.title = nil
            tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    
    private func configureNavigationBar() {
        guard let navBar = navigationController?.navigationBar else { return }
        navBar.barTintColor = .white
        navBar.clearShadow()
        let backButtonInsets = UIEdgeInsets(top: 13, left: 20, bottom: 0, right: 0)
        let backButtonImage = R.image.back()?
            .withRenderingMode(.alwaysOriginal)
            .withAlignmentRectInsets(backButtonInsets)
        navBar.backIndicatorImage = backButtonImage
        navBar.backIndicatorTransitionMaskImage = backButtonImage
    }
}

extension TabBarViewController: TabBarViewing {
    
    var tabBarViewControllers: [UIViewController]? {
        get {
            return self.viewControllers
        } set {
            self.viewControllers = newValue
        }
    }
    
}
