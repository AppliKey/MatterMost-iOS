//
//  MainRouting.swift
//  Mattermost
//
//  Created by iOS_Developer on 17.11.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import UIKit

protocol MainRouting : NavigationRouting {
    
    var rootController : UIViewController { get }
    
    func embed(sideViewController controller: UIViewController)
    func embed(centerViewController controller: UIViewController)
    func toggleMenu()
    
    func addViewController(_ viewController: UIViewController)
    func deleteFirstViewController()
    
}
