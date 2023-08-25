//
//  Settings.swift
//  CryptoWallet
//
//  Created by mac on 2.03.23.
//

import Foundation

final class AuthorizationSettings {
    static let shared = AuthorizationSettings()
    
    enum UserDefaultsKeys: String {
        case isAuth
    }
    
    var isAuth: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isAuth.rawValue)
        }
        get { return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isAuth.rawValue)}
    }
}









