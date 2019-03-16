//
//  Constants.swift
//  BitNow
//
//  Created by Luca Lo Forte on 16/03/2019.
//  Copyright © 2019 Luca Lo Forte. All rights reserved.
//

import Foundation

//URL + Header
let BASE_URL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

//Typealias
typealias CurrencyResponseCompletion = (String?) -> Void
