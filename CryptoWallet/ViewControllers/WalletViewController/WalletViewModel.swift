//
//  WalletViewModel.swift
//  CryptoWallet
//
//  Created by mac on 20.03.23.
//

import UIKit

enum Sort {
    case ascending
    case descending
}

final class WalletViewModel: WalletProtocolIn, WalletProtocolOut {
    var dataCoins = [CryptoModel]()
    var reloadTableView: () -> Void = {}
    var showError: (Error) -> Void = { _ in }
    var dataSortedCoins = FlagSorted.origin
    var error = [Error]()
    
//    func cell(for indexPath: IndexPath) -> UITableViewCell {
//        return UITableViewCell()
//    }
    
    func height(forRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    private let model = WalletModel()
    
    func getData() {
        let dispatchGroup = DispatchGroup()
        let urlArray = Coins.allCases.map { $0.rawValue }
        _ = urlArray.map { url in
            
            dispatchGroup.enter()
            NetworkServiceManager.shared.getWallet(with: url) { [weak self] result in
                switch result {
                case .success(let coin):
                    self?.dataCoins.append(CryptoModel(crypto: coin))
                case .failure(let error):
                    self?.error.append(error)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.reloadTableView()
            if let error = self?.error.first {
                self?.showError(error)
            }
        }
    }
    
    func sortedCoins() -> [CryptoModel] {
        switch dataSortedCoins {
        case .origin:
            return dataCoins
        case .sorted:
            return dataCoins.sorted { $0.percentChangeUsdLastDay > $1.percentChangeUsdLastDay }
        }
    }
}

