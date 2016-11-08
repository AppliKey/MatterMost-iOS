//
//  UnreadUnreadViewController.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 08/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class UnreadViewController: UIViewController {
	
	//MARK: - Properties
  	var eventHandler: UnreadEventHandling!
  
  	//MARK: - Life cycle

	override func viewDidLoad() {
		super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.icMenu(), style: .done,
                                                           target: self, action: #selector(openMenuPressed(_:)))
        configureInterface()
	}
    
    //MARK: -
    
    func openMenuPressed(_ sender:AnyObject) {
        eventHandler.openMenu()
    }

	//MARK: - Private -

	//MARK: - UI
    
    private func configureInterface() {
        localizeViews()
    }
    
    private func localizeViews() {
    }

}

extension UnreadViewController: UnreadViewing {
}
