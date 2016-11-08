//
//  MenuMenuViewController.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController {
	
	//MARK: - Properties
  	var eventHandler: MenuEventHandling!
  
  	//MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureInterface()
    }
    
    //MARK: -
    
    func goBack(_ sender:AnyObject) {
        eventHandler.goBack(fromViewController: self)
    }

	//MARK: - Private -

	//MARK: - UI
    
    private func configureInterface() {
        localizeViews()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.back(), style: .done,
                                                           target: self, action: #selector(goBack(_:)))
    }
    
    private func localizeViews() {
    }

}

extension MenuViewController: MenuViewing {
}
