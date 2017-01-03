//
//  NewGroupNewGroupPresenter.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 19/12/2016.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

class NewGroupPresenter: NewGroupConfigurator {
    
	//MARK: - Properties
    weak var view: NewGroupViewing!
    var interactor: NewGroupInteracting!
	
	//MARK: - Init
    
    required init(coordinator: NewGroupCoordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: - Private -
    fileprivate let coordinator: NewGroupCoordinator
    fileprivate var users = Array<User>()
    fileprivate var searchedUsers = Array<User>()
    fileprivate var members = Set<User>()
    fileprivate var searchString = ""
    fileprivate var usersToShow: [User] {
        return searchString.isEmpty ? users : searchedUsers
    }
}

extension NewGroupPresenter: NewGroupEventHandling {
    
    func viewDidLoad() {
        interactor.loadUsers()
    }
    
    func didSelectUserAt(_ index: Int, update: (UserRepresantation) -> Void) {
        let user = usersToShow[index]
        updateMembersWith(user)
        update(representation(for: user))
    }
    
    fileprivate func updateMembersWith(_ user: User) {
        if members.contains(user) {
            members.remove(user)
        } else {
            members.insert(user)
        }
        let urls = members.sorted{$0.0.username < $0.1.username}.flatMap{$0.avatarUrl}
        let membersInfo = MembersInfoRepresentation(count: members.count, urls: urls)
        view.updateMembersInfo(membersInfo)
    }
    
    func didChangeSearchString(_ searchString: String) {
        self.searchString = searchString
        updateSearchedUsers()
        showUsers()
    }
    
    private func updateSearchedUsers() {
        if searchString.isEmpty {
            self.searchedUsers = []
        } else {
            self.searchedUsers = users.filter({
                let usernameContains = $0.username.containsIgnoringCase(searchString)
                let firstnameContains = $0.firstname?.containsIgnoringCase(searchString) ?? false
                let lastnameContains = $0.lastname?.containsIgnoringCase(searchString) ?? false
                let emailContains = $0.email?.containsIgnoringCase(searchString) ?? false
                return usernameContains || firstnameContains || lastnameContains || emailContains
            })
        }
    }
    
    fileprivate func showUsers() {
        let represantations = usersToShow.map(representation)
        view.show(represantations)
    }
    
}

extension NewGroupPresenter: NewGroupPresenting {
    
    func present(_ users: [User]) {
        self.users = users
        showUsers()
    }
    
    func present(_ errorMessage: String) {
        view.alert(errorMessage)
    }
    
    fileprivate func representation(for user: User) -> UserRepresantation {
        let isSelected = members.contains(user)
        return UserRepresantation(name: user.username, avatarURL: user.avatarUrl,
                                  selected: isSelected)
    }
    
}

struct UserRepresantation {
    let name: String
    let avatarURL: URL?
    var isSelected = false
    
    init(name: String, avatarURL: URL?, selected: Bool = false) {
        self.name = name
        self.avatarURL = avatarURL
        self.isSelected = selected
    }
    
}

struct MembersInfoRepresentation {
    let count: Int
    let urls: [URL]
}
