//
//  ViewController.swift
//  BitNow
//
//  Created by Luca Lo Forte on 16/03/2019.
//  Copyright © 2019 Luca Lo Forte. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    //Outlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    //Variables
    let currencyArray = ["AUD","BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR",
                         "JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
        initialRequest()
    }
    
    func setupPickerView() {
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }
    
    func initialRequest() {
        BitcoinService.instance.getPrice(currency: currencyArray[0]) { (price) in
            self.setPrice(price)
        }
    }
    
    func setPrice(_ price: String?) {
        if let price = price {
            self.bitcoinPriceLabel.text = price
        } else {
            self.bitcoinPriceLabel.text = "Price Unavailable"
        }
    }
}

extension HomeVC : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = currencyArray[row]
        return NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        BitcoinService.instance.getPrice(currency: currencyArray[row]) { (price) in
            self.setPrice(price)
        }
    }
    
}

