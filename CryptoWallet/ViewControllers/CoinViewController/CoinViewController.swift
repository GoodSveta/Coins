//
//  CoinViewController.swift
//  CryptoWallet
//
//  Created by mac on 10.03.23.
//

import UIKit

final class CoinViewController: BaseViewController {
    
    init(model: CryptoModel) {
        let rounding = NumberFormatter()
        labelCoinName.text = model.name
        labelSymbol.text = model.symbol
        labelCoinPrice.text = "\(rounding.getFormattedNumber(format: model.priceUsd) ?? "")$"
        labelValueChange.text = "\(rounding.getFormattedNumber(format: model.percentChangeUsdLastDay) ?? "")%"
        currentMarketCap.text = rounding.getFormattedNumber(format: model.currentMarketcapUsd)
        rank.text = "# \(model.rank)"
        volume.text = rounding.getFormattedNumber(format: model.volume)
        open.text = rounding.getFormattedNumber(format: model.open)
        close.text = rounding.getFormattedNumber(format: model.close)
        high.text = rounding.getFormattedNumber(format: model.high)
        low.text = rounding.getFormattedNumber(format: model.low)
        
        if model.percentChangeUsdLastDay < 0 {
            imageValueChange.image = UIImage(systemName: ImageName.down.rawValue)
            imageValueChange.tintColor = .red
        } else {
            imageValueChange.image = UIImage(systemName: ImageName.up.rawValue)
            imageValueChange.tintColor = .green
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    var coinVM: (CoinProtocolIn & CoinProtocolOut)?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let viewSecond: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1510096192, green: 0.1431435645, blue: 0.2380613387, alpha: 0.9341944006)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let labelCoinName: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 30)
        return label
    }()
    
    private let labelSymbol: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 14)
        return label
    }()
    
    private let labelCoinPrice: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 18)
        return label
    }()
    
    private let labelValueChange: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 15)
        return label
    }()
    
    private let imageValueChange: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let labelMarketData: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.text = "MARKET DATA"
        label.font = UIFont(name: "Thonburi", size: 14)
        return label
    }()
    
    private let labelCurrentMarketCap: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.text = "Market Cap"
        label.font = UIFont(name: "Thonburi", size: 14)
        return label
    }()
    
    private let currentMarketCap: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 17)
        return label
    }()
    
    private let labelRank: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.text = "Rank"
        label.font = UIFont(name: "Thonburi", size: 14)
        return label
    }()
    
    private let rank: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 17)
        return label
    }()
    
    private let labelVolume: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.text = "Volume(24h)"
        label.font = UIFont(name: "Thonburi", size: 13)
        return label
    }()
    
    private let volume: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 14)
        return label
    }()
    
    private let labelOpen: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.text = "Open"
        label.font = UIFont(name: "Thonburi", size: 13)
        return label
    }()
    
    private let open: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 14)
        return label
    }()
    
    private let labelClose: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.text = "Close"
        label.font = UIFont(name: "Thonburi", size: 13)
        return label
    }()
    
    private let close: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 14)
        return label
    }()
    
    private let labelHigh: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.text = "High(24h)"
        label.font = UIFont(name: "Thonburi", size: 13)
        return label
    }()
    
    private let high: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 14)
        return label
    }()
    
    private let labelLow: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.text = "Low(24h)"
        label.font = UIFont(name: "Thonburi", size: 13)
        return label
    }()
    
    private let low: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont(name: "Thonburi", size: 14)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func addViews() {
        [labelCoinName, labelCoinPrice,labelSymbol, labelValueChange, imageValueChange, viewSecond, imageValueChange, labelMarketData].forEach({
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        [labelCurrentMarketCap, currentMarketCap, labelRank, rank, labelVolume, volume, labelOpen, open, labelClose, close, labelHigh, high, labelLow, low].forEach({
            viewSecond.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    
    override func setupLayout() {
        view.addConstraints([
            labelCoinName.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            labelCoinName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            labelSymbol.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelSymbol.topAnchor.constraint(equalTo: labelCoinName.bottomAnchor, constant: 9),
            
            labelCoinPrice.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelCoinPrice.topAnchor.constraint(equalTo: labelSymbol.bottomAnchor, constant: 18),
            
            labelValueChange.centerXAnchor.constraint(equalTo: labelCoinPrice.centerXAnchor, constant: 5),
            labelValueChange.topAnchor.constraint(equalTo: labelCoinPrice.bottomAnchor, constant: 12),
            
            imageValueChange.topAnchor.constraint(equalTo: labelValueChange.topAnchor),
            imageValueChange.trailingAnchor.constraint(equalTo: labelValueChange.leadingAnchor, constant: -8),
            imageValueChange.bottomAnchor.constraint(equalTo: labelValueChange.bottomAnchor),
            imageValueChange.widthAnchor.constraint(equalToConstant: 20),
            
            viewSecond.topAnchor.constraint(equalTo: labelMarketData.bottomAnchor, constant: 5),
            viewSecond.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            viewSecond.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            viewSecond.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            labelMarketData.topAnchor.constraint(equalTo: labelValueChange.bottomAnchor, constant: 30),
            labelMarketData.leadingAnchor.constraint(equalTo: viewSecond.leadingAnchor, constant: 5),
            
            labelCurrentMarketCap.topAnchor.constraint(equalTo: viewSecond.topAnchor, constant: 10),
            labelCurrentMarketCap.leadingAnchor.constraint(equalTo: viewSecond.leadingAnchor, constant: 10),
            
            currentMarketCap.leadingAnchor.constraint(equalTo: labelCurrentMarketCap.leadingAnchor, constant: 0),
            currentMarketCap.topAnchor.constraint(equalTo: labelCurrentMarketCap.bottomAnchor, constant: 6),
            
            labelRank.topAnchor.constraint(equalTo: viewSecond.topAnchor, constant: 10),
            labelRank.trailingAnchor.constraint(equalTo: viewSecond.trailingAnchor, constant: -20),
            rank.topAnchor.constraint(equalTo: labelRank.bottomAnchor, constant: 6),
            rank.leadingAnchor.constraint(equalTo: labelRank.leadingAnchor, constant: 0),
            
            labelVolume.topAnchor.constraint(equalTo: currentMarketCap.bottomAnchor, constant: 30),
            labelVolume.leadingAnchor.constraint(equalTo: currentMarketCap.leadingAnchor, constant: 0),
            
            volume.topAnchor.constraint(equalTo: labelVolume.bottomAnchor, constant: 6),
            volume.leadingAnchor.constraint(equalTo: labelVolume.leadingAnchor, constant: 0),
            
            labelOpen.topAnchor.constraint(equalTo: volume.bottomAnchor, constant: 20),
            labelOpen.leadingAnchor.constraint(equalTo: volume.leadingAnchor, constant: 0),
            
            open.topAnchor.constraint(equalTo: labelOpen.bottomAnchor, constant: 6),
            open.leadingAnchor.constraint(equalTo: labelOpen.leadingAnchor, constant: 0),
            
            labelClose.topAnchor.constraint(equalTo: labelOpen.topAnchor, constant: 0),
            labelClose.leadingAnchor.constraint(equalTo: viewSecond.centerXAnchor, constant: -20),
            
            close.topAnchor.constraint(equalTo: labelClose.bottomAnchor, constant: 6),
            close.leadingAnchor.constraint(equalTo: labelClose.leadingAnchor, constant: 0),
            
            labelHigh.topAnchor.constraint(equalTo: open.bottomAnchor, constant: 15),
            labelHigh.leadingAnchor.constraint(equalTo: open.leadingAnchor, constant: 0),
            
            high.topAnchor.constraint(equalTo: labelHigh.bottomAnchor, constant: 6),
            high.leadingAnchor.constraint(equalTo: labelHigh.leadingAnchor, constant: 0),
            
            labelLow.topAnchor.constraint(equalTo: close.bottomAnchor, constant: 15),
            labelLow.leadingAnchor.constraint(equalTo: close.leadingAnchor, constant: 0),
            
            low.topAnchor.constraint(equalTo: labelLow.bottomAnchor, constant: 6),
            low.leadingAnchor.constraint(equalTo: labelLow.leadingAnchor, constant: 0)
        ])
    }
}

