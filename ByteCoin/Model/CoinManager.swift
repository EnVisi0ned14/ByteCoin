//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol BitCoinPropertiesDelegate {
    func didUpdatePrice(bitcoinProperties : InformationHandler)
    
}

struct CoinManager : BitCoinPropertiesDelegate {
    
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "59879F99-5D06-481C-9160-8D5000AA4A8D" 
    
    var delegate : BitCoinPropertiesDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
    
    func bitCoinPrice(from currencyType : String) {
        let url = "\(baseURL)/\(currencyType)?apikey=\(apiKey)"
        if let urlString = URL(string: url) {
            performRequest(from: urlString)
        }
        
    }
    
    func performRequest(from url : URL) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            if error != nil {
                print(error!)
            }
            if let safeData = data {
                let bitcoinProperties = parseJSON(data: safeData)
                delegate?.didUpdatePrice(bitcoinProperties: bitcoinProperties)
                
            }
        })
        task.resume()
    }
    
    func parseJSON (data : Data) -> InformationHandler {
        let decoder = JSONDecoder()
        let bitcoinProperties = try! decoder.decode(InformationHandler.self, from: data)
        return bitcoinProperties
        }

        
    
    func didUpdatePrice(bitcoinProperties: InformationHandler) {
        
    }

}
