//
//  BitcoinService.swift
//  BitNow
//
//  Created by Luca Lo Forte on 16/03/2019.
//  Copyright © 2019 Luca Lo Forte. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class BitcoinService {
    static let instance = BitcoinService()
    
    func getPrice(currency: String, completion: @escaping CurrencyResponseCompletion) {
        guard let url = URL(string: "\(BASE_URL)\(currency)") else { return }
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if let error = response.result.error {
                debugPrint(error.localizedDescription)
                completion(nil)
                return
            }
            guard let data = response.data else { return completion(nil) }
            do {
                let json = try JSON(data: data)
                guard let price = self.parsePrice(json: json) else {return completion(nil)}
                let fullPrice = self.createFullPrice(price: price, currency: currency)
                DispatchQueue.main.async {
                    completion(fullPrice)
                }
            } catch {
                debugPrint(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    //Parsing with SwiftyJson
    func parsePrice(json: JSON) -> Double? {
        let price = json["ask"].double
        return price
    }
    
    func createFullPrice(price: Double, currency: String) -> String? {
        switch currency {
        case "AUD":
            return "$ \(price)"
        case "BRL":
            return "R$ \(price)"
        case "CAD":
            return "$ \(price)"
        case "CNY":
            return "¥ \(price)"
        case "EUR":
            return "€ \(price)"
        case "GBP":
            return "£ \(price)"
        case "HKD":
            return "$ \(price)"
        case "IDR":
            return "Rp \(price)"
        case "ILS":
            return "₪ \(price)"
        case "INR":
            return "₹ \(price)"
        case "JPY":
            return "¥ \(price)"
        case "MXN":
            return "$ \(price)"
        case "NOK":
            return "kr \(price)"
        case "NZD":
            return "$ \(price)"
        case "PLN":
            return "zł \(price)"
        case "RON":
            return "lei \(price)"
        case "RUB":
            return "₽ \(price)"
        case "SEK":
            return "kr \(price)"
        case "SGD":
            return "$ \(price)"
        case "USD":
            return "$ \(price)"
        case "ZAR":
            return "R \(price)"
        default:
            return nil
        }
    }
    
}
