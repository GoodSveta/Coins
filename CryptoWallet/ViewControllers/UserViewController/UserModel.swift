//
//  UserModel.swift
//  CryptoWallet
//
//  Created by mac on 14.02.23.
//

import Foundation

struct UserModel {
    let login: String?
    let passwords: String?
}

extension UserModel {
    static var logins = [
        UserModel(login: "1234", passwords: "1234")]
}
