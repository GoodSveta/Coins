//
//  Wallet.swift
//  CryptoWallet
//
//  Created by mac on 5.03.23.
//

import Foundation

struct CryptoModel {
    let name: String
    let symbol: String
    let priceUsd: Double
    let percentChangeUsdLastDay: Double
    let currentMarketcapUsd: Double
    let rank: Int
    let volume: Double
    let open: Double
    let high: Double
    let low: Double
    let close: Double
    
    init(crypto: Crypto) {
        self.name = crypto.data?.name ?? ""
        self.symbol = crypto.data?.symbol ?? ""
        self.priceUsd = crypto.data?.marketData?.priceUsd ?? 0
        self.percentChangeUsdLastDay = crypto.data?.marketData?.percentChangeUsdLastDay ?? 0
        self.currentMarketcapUsd = crypto.data?.marketcap?.currentMarketcapUsd ?? 0.0
        self.rank = crypto.data?.marketcap?.rank ?? 0
        self.volume = crypto.data?.marketData?.ohlcvLastDay?.volume ?? 0.0
        self.open = crypto.data?.marketData?.ohlcvLastDay?.open ?? 0.0
        self.high = crypto.data?.marketData?.ohlcvLastDay?.high ?? 0.0
        self.low = crypto.data?.marketData?.ohlcvLastDay?.low ?? 0.0
        self.close = crypto.data?.marketData?.ohlcvLastDay?.close ?? 0.0
    }
}

struct Crypto: Codable {
    let data: DataWallet?
}

struct DataWallet: Codable {
    let id: String?
    let symbol: String?
    let name: String?
    let marketData: MarketData?
    let marketcap: Marketcap?
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case marketData = "market_data"
        case marketcap
    }
}

struct MarketData: Codable {
    let priceUsd: Double?
    let percentChangeUsdLastHour: Double?
    let percentChangeUsdLastDay: Double?
    let volumeLastDay: Double?
    let ohlcvLastDay: OhlcvLastHour?
    
    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case percentChangeUsdLastHour = "percent_change_usd_last_1_hour"
        case percentChangeUsdLastDay = "percent_change_usd_last_24_hours"
        case volumeLastDay = "volumeLast24_Hours"
        case ohlcvLastDay = "ohlcv_last_24_hour"
    }
}

struct Marketcap: Codable {
    let rank: Int?
    let currentMarketcapUsd: Double?
    
    enum CodingKeys: String, CodingKey {
        case rank
        case currentMarketcapUsd = "current_marketcap_usd"
    }
}

struct OhlcvLastHour: Codable {
    let ohlcvLastDay: Double?
    let open: Double?
    let high: Double?
    let low: Double?
    let close: Double?
    let volume: Double?
    
    enum CodingKeys: String, CodingKey {
        case ohlcvLastDay = "ohlcv_last_24_hour"
        case open
        case high
        case low
        case close
        case volume
    }
}



