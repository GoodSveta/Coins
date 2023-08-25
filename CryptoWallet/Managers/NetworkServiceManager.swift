//
//  NetworkServiceManager.swift
//  CryptoWallet
//
//  Created by mac on 5.03.23.
//

import Foundation

enum ResponseError: Error, LocalizedError {
    case errorStatusCode
    var errorDescription: String? {
        switch self {
        case .errorStatusCode:
            return "Error status code"
        }
    }
}

final class NetworkServiceManager {
    static let shared = NetworkServiceManager()
    
    func getWallet(with coin: String, onCompleted: @escaping (Result<(Crypto), Error>) -> Void) {
        
        guard let url = APIWallet.wallet.getWalletURL(with: coin) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                onCompleted(.failure(error))
            }
            guard let httpsResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpsResponse.statusCode) else {
                onCompleted(.failure(ResponseError.errorStatusCode))
                return
            }
            print(httpsResponse.statusCode)
            
            guard let data = data else { return }
            do {
                let task = try JSONDecoder().decode(Crypto.self, from: data)
                DispatchQueue.main.async {
                    onCompleted(.success(task))
                }
            } catch (let e) {
                DispatchQueue.main.async {
                    onCompleted(.failure(e))
                }
            }
        }.resume()
    }
    
    func getCryptoIcon(nameCrypto: String, cryptoSymbol: String, completion: @escaping (Data) -> Void) {
        guard let cryptoIconURL = URL(string: "https://cryptologos.cc/logos/\(nameCrypto)-\(cryptoSymbol)-logo.png?v=024") else { return }
        URLSession.shared.dataTask(with: cryptoIconURL) { data, _, _ in
            guard let data = data else { return }
            completion(data)
        }.resume()
    }
}

