//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Luke Tarr on 05/03/2019
//  MIT Licensed
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    //Set URL to API and array of currencies avaliable along with their symbol and the users current row
    let btcURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let symbolArray = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var currentRow : Int = 0
    //Create the two UI elements
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set the delegate and data source of the picker to ViewController
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }
    
    //Set up the pickerview protocol requirements
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //When a picker element is chosen, create the url and call getPriceData on that url
        let url = btcURL + currencyArray[row]
        currentRow = row
        getPriceData(url: url)
    }
    
    func getPriceData(url: String) {
        //Use Alamofire to get request the BTC API and return a reponse
        Alamofire.request(url, method: .get, parameters: ["":""])
            .responseJSON { response in
                //If the response is successfull, get the JSON returned and call updateBTCData on it
                if response.result.isSuccess {
                    let btcJSON : JSON = JSON(response.result.value!)
                    self.updateBTCData(json: btcJSON)

                } else {
                    //If the response if false print it to standard output and set the label to show unavailability
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
            }

    }

    func updateBTCData(json : JSON) {
        //If the JSON can be parsed with the current asking price of BTC, update the label with it
        if let result = json["ask"].double {
            bitcoinPriceLabel.text = symbolArray[currentRow] + String(result)
        } else {
            //If the current asking price cannot be parsed, update the label to show unavailability
            bitcoinPriceLabel.text = "Unavailable..."
        }
    }
}

