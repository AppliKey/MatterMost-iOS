//
//  ChatsChatsViewController.swift
//  Mattermost
//
//  Created by Smetankin Dmitry on 16/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class ChatsViewController: UIViewController {
	
	//MARK: - Properties
  	var eventHandler: ChatsEventHandling!
  
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

extension ChatsViewController: ChatsViewing {
}
