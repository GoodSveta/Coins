//
//  UserViewModel.swift
//  CryptoWallet
//
//  Created by mac on 12.03.23.
//

import Foundation

enum StatusText: String {
    case failed = "log in failed"
    case successful = "successfully"
}

final class UserViewModel: UserProtocolIn, UserProtocolOut {
    var updateView: (String) -> Void = { _ in }
    
    func userButtonPressed(login: String, password: String) -> Bool {
        if login != UserModel.logins[0].login || password != UserModel.logins[0].passwords {
            updateView(StatusText.failed.rawValue)
            print(updateView)
            return false
        } else {
            updateView(StatusText.successful.rawValue)
            AuthorizationSettings.shared.isAuth = true
            return true
        }
    }
}
