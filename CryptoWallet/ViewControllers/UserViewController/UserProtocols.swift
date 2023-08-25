//
//  UserProtocols.swift
//  CryptoWallet
//
//  Created by mac on 12.03.23.
//

import Foundation

protocol UserProtocolIn {
    func userButtonPressed(login: String, password: String) -> Bool
}

protocol UserProtocolOut {
    var updateView: (String) -> Void { get set }
    
}
