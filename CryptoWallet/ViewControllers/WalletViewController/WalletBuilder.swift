//
//  WalletBuilder.swift
//  CryptoWallet
//
//  Created by mac on 20.03.23.
//

import UIKit

final class Builder {
    static func build() -> UIViewController {
        let walletVM = WalletViewModel()
        let walletVC = WalletViewController(walletVM: walletVM)
        
        return walletVC
    }
}
