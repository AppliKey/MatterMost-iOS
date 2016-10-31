//
// Created by Vladimir Kravchenko on 3/2/16.
// Copyright (c) 2016 Applikey Solutions. All rights reserved.
//

import Foundation
import UIKit

//MARK: Base protocols

internal protocol BasePresenter: class {
    associatedtype InteractorType
    associatedtype RouterType
    associatedtype ViewType
    associatedtype CoordinatorType
    
    var interactor: InteractorType! {get set}
    var router: RouterType! {get set}
    
    init(withView view: ViewType, coordinator: CoordinatorType)
}

internal protocol BaseView: class {
    associatedtype EventHandlerType
    var eventHandler: EventHandlerType! {get set}
}

internal protocol BaseInteractor: class {
    associatedtype PresenterType
    var presenter: PresenterType! {get set} //should be weak
}

internal protocol BaseRouter: class {
    weak var viewController: UIViewController! {get set}
}

internal protocol BaseModule: class {
    associatedtype ConfiguratorType
    var viewController: UIViewController {get}
    init(withViewController viewController: UIViewController, configurator: ConfiguratorType)
}
