//
//  APIs.swift
//  CryptoWallet
//
//  Created by mac on 5.03.23.
//

import Foundation

enum Coins: String, CaseIterable {
    case btc
    case eth
    case tron
    case luna
    case polkadot
    case dogecoin
    case tether
    case stellar
    case cardano
    case xrp
}

enum APIWallet: String {
    case hostWallet = "https://data.messari.io/api"
    case wallet = "/v1/assets/%@/metrics"
    
    var url: URL? {
        return URL(string: APIWallet.hostWallet.rawValue + self.rawValue)
    }
    
    func getWalletURL(with nameCoin: String) -> URL? {
        let string = APIWallet.hostWallet.rawValue + self.rawValue
        let completedString = String(format: string, nameCoin)
        return URL(string: completedString)
    }
}

