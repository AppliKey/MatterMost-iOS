//
//  MenuMenuPresenter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 07/11/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class MenuPresenter {
    
	//MARK: - Properties
    weak var view: MenuViewing!
    var interactor: MenuInteracting!
	
	//MARK: - Init
    
    required init(coordinator: MenuCoordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: - Private -
    fileprivate let coordinator: MenuCoordinator
}

extension MenuPresenter: MenuConfigurator {
}

extension MenuPresenter: MenuPresenting {
}

extension MenuPresenter: MenuEventHandling {
    func viewIsReady() {
        let vm = MenuViewModel()
        view.updateView(withViewModel: vm)
    }
    
    func handleRowSelection(withIndexPath index: IndexPath) {
        switch index.row {
        case 0:
            debugPrint("All channels")
        case 1:
            debugPrint("Invite new members")
        default:
            coordinator.openSettings()
        }
    }
}
