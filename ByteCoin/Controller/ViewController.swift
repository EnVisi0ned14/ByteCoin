//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, BitCoinPropertiesDelegate {

    


    @IBOutlet weak var bitcoinPrice: UILabel!
    
    @IBOutlet weak var currencyType: UILabel!
    
    @IBOutlet weak var currencySelectionPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        currencySelectionPicker.dataSource = self
        currencySelectionPicker.delegate = self
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(updateCounting), userInfo: nil, repeats: true)
        coinManager.bitCoinPrice(from: "AUD")
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyType.text = coinManager.currencyArray[row]
        
    }
    

    
    @objc func updateCounting(){
        coinManager.bitCoinPrice(from: currencyType.text ?? "")
    }
    
    func didUpdatePrice(bitcoinProperties: InformationHandler) {
        let price = bitcoinProperties.rate
        let roundedPrice = round(price * 100)/100
        DispatchQueue.main.async {
            self.bitcoinPrice.text = String(roundedPrice)
        }
    }
    

}

