//
//  WalletProtocols.swift
//  CryptoWallet
//
//  Created by mac on 20.03.23.
//

import UIKit

protocol WalletProtocolIn: AnyObject {
    var dataCoins: [CryptoModel] { get set }
    var dataSortedCoins: FlagSorted { get set }
    func getData()
    func sortedCoins() -> [CryptoModel]
//    func cell(for indexPath: IndexPath) -> UITableViewCell
    func height(forRowAt indexPath: IndexPath) -> CGFloat
}

protocol WalletProtocolOut {
    var reloadTableView: () -> Void { get set }
    var showError: (Error) -> Void { get set }
}
