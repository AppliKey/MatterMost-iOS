//
//  AuthorizationCoordinator.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 27.10.16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation
import UIKit

class AuthorizationCoordinator {
    
    //MARK: - Init
    init(withRouter router: AuthorizationRouter, appCoordinator: AppCoordinator) {
        self.router = router
        self.appCoordinator = appCoordinator
    }
    
    func start() {
        doWithoutAnimation {
            selectServerAddress()
            if SessionManager.shared.serverAddress != nil {
                signIn()
            }
            if SessionManager.shared.token != nil {
                selectTeam()
            }
        }
    }
    
    //MARK: - Private - 
    fileprivate let router: AuthorizationRouter
    fileprivate unowned let appCoordinator: AppCoordinator
    fileprivate var animated = true
    
    fileprivate func doWithoutAnimation(_ closure: VoidClosure) {
        animated = false
        closure()
        animated = true
    }
    
    fileprivate func selectServerAddress() {
        guard let viewController = R.storyboard.authorization.serverSelectionViewController()
            else { fatalError("Can't instantiate server selection view controller") }
        ServerSelectionWireframe.setup(viewController, withCoordinator: self)
        router.root(viewController: viewController, animated: animated)
    }
    
}

//MARK: - ServerSelectionCoordinator
extension AuthorizationCoordinator: ServerSelectionCoordinator {
    
    func signIn() {
        guard let viewController = R.storyboard.authorization.signInViewController()
            else { fatalError("Can't instantiate sign in view controller") }
        SignInWireframe.setup(viewController, withCoordinator: self)
        router.push(viewController: viewController, animated: animated)
    }
    
}

//MARK: - SignInCoordinator
extension AuthorizationCoordinator: SignInCoordinator {
    
    func forgotPass(forEmail email: String) {
        guard let viewController = R.storyboard.authorization.forgotPassViewController()
            else { fatalError("Can't instantiate forgot pass view controller") }
        ForgotPassWireframe.setup(viewController, withCoordinator: self) {
            $0.email = email
        }
        router.push(viewController: viewController, animated: true)
    }
    
    func selectTeam() {
        guard let viewController = R.storyboard.authorization.teamSelectionViewController()
            else { fatalError("Can't instantiate forgot pass view controller") }
        TeamSelectionWireframe.setup(viewController, withCoordinator: self)
        router.push(viewController: viewController, animated: animated)
    }
    
}

//MARK: - TeamSelectionCoordinator
extension AuthorizationCoordinator: TeamSelectionCoordinator {
    func showMain() {
        appCoordinator.showMainScreen()
    }
}

//MARK: - ForgotPassCoordinator
extension AuthorizationCoordinator: ForgotPassCoordinator {
    
}

