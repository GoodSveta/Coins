//
//  UserBuilder.swift
//  CryptoWallet
//
//  Created by mac on 20.03.23.
//

import UIKit

final class UserBuilder {
    static func build() -> UIViewController {
        let userVC = UserViewController()
        let userVM = UserViewModel()
        userVC.userVM = userVM
        
        return userVC
    }
}
