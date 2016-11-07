//
//  Validators.swift
//  Mattermost
//
//  Created by Vladimir Kravchenko on 11/7/16.
//  Copyright © 2016 AppliKey Solutions. All rights reserved.
//

import Foundation

protocol EmailValidator {
    func validateEmail(_ email: String) -> Bool
}

extension EmailValidator {
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}

protocol PasswordValidator {
    func validatePassword(_ password: String) -> Bool
}

extension PasswordValidator {
    func validatePassword(_ password: String) -> Bool {
        return password.characters.count > 3
    }
}
