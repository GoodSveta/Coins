//
//  WalletTableViewCell.swift
//  CryptoWallet
//
//  Created by mac on 4.03.23.
//

import UIKit

final class WalletTableViewCell: UITableViewCell {
    
    private var nameCoin: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Thonburi", size: 17)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    private var coinPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Thonburi", size: 13)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    private var coinValueChange: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Thonburi", size: 13)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    private let imageValueChange: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let imageCryptoIcon: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [nameCoin, coinPrice, coinValueChange, imageValueChange, imageCryptoIcon].forEach({ contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false })
        
        setupLayout()
        setupStyle()
    }
    
    private func setupLayout() {
        contentView.addConstraints([
            imageCryptoIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            imageCryptoIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            imageCryptoIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            imageCryptoIcon.widthAnchor.constraint(equalToConstant: 60),
            
            nameCoin.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameCoin.leadingAnchor.constraint(equalTo: imageCryptoIcon.trailingAnchor, constant: 8),
            
            coinPrice.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -110),
            coinPrice.topAnchor.constraint(equalTo: nameCoin.topAnchor, constant: 0),
            
            imageValueChange.topAnchor.constraint(equalTo: coinPrice.bottomAnchor, constant: 8),
            imageValueChange.leadingAnchor.constraint(equalTo: coinPrice.leadingAnchor, constant: 0),
            
            coinValueChange.topAnchor.constraint(equalTo: coinPrice.bottomAnchor, constant: 8),
            coinValueChange.leadingAnchor.constraint(equalTo: imageValueChange.trailingAnchor, constant: 3)
        ])
    }
    
    private func setupStyle() {
        contentView.backgroundColor = #colorLiteral(red: 0.1570645571, green: 0.1514831483, blue: 0.254172802, alpha: 0.9696157089)
    }
    
    func setupCell(with wallet: CryptoModel) {
        
        let rounding = NumberFormatter()
        nameCoin.text = wallet.name
        coinValueChange.text = "\(rounding.getFormattedNumber(format: wallet.percentChangeUsdLastDay) ?? "")%"
        coinValueChange.textAlignment = .left
        coinPrice.text = "\(rounding.getFormattedNumber(format: wallet.priceUsd) ?? "")$"
        coinPrice.textAlignment = .left
        
        NetworkServiceManager.shared.getCryptoIcon(nameCrypto: wallet.name.lowercased(), cryptoSymbol: wallet.symbol.lowercased()) { data in
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    self.imageCryptoIcon.image = UIImage(named: ImageName.icon.rawValue)
                    return
                }
                self.imageCryptoIcon.image = image
            }
        }
        
        if wallet.percentChangeUsdLastDay < 0 {
            coinValueChange.textColor = .red
            imageValueChange.image = UIImage(systemName: ImageName.down.rawValue)
            imageValueChange.tintColor = .red
        } else {
            coinValueChange.textColor = .green
            imageValueChange.image = UIImage(systemName: ImageName.up.rawValue)
            imageValueChange.tintColor = .green
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

