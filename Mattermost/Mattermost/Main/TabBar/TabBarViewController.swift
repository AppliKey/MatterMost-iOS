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
        configureInterface()
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
}

extension TabBarViewController: TabBarViewing {
    func showBadge(atController controller: TabBarControllers) {
        var tabBarItem: UITabBarItem
        switch controller {
        case .Favourites:
            tabBarItem = UITabBarItem(title: nil,
                                      image: R.image.ic_favorites_new(),
                                      selectedImage: R.image.ic_favorites())
        case .PublicChannels:
            tabBarItem = UITabBarItem(title: nil,
                                      image: R.image.ic_public_chanels_new(),
                                      selectedImage: R.image.ic_public_chanels())
        case .PrivateChannels:
            tabBarItem = UITabBarItem(title: nil,
                                      image: R.image.ic_private_chanels_new(),
                                      selectedImage: R.image.ic_private_chanels())
        case .Direct:
            tabBarItem = UITabBarItem(title: nil,
                                      image: R.image.ic_direct_new(),
                                      selectedImage: R.image.ic_direct())
        }
        tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        let index = viewControllers?.count == 5 ? controller.rawValue + 1 : controller.rawValue
        viewControllers?[index].tabBarItem = tabBarItem
    }
}
