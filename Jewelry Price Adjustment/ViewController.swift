//
//  ViewController.swift
//  Jewelry Price Adjustment
//
//  Created by johnny on 7/1/20.
//  Copyright © 2020 johnny. All rights reserved.
//
import UIKit
import SwiftSoup

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var purchaseDateTxt: UITextField!
    @IBOutlet weak var gpTodayDisplay: UILabel!
    @IBOutlet weak var pcTodayDisplay: UILabel!
    @IBOutlet weak var purchasePrice: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var swipeMade: UISwipeGestureRecognizer!
    
    let datePicker = UIDatePicker()
    let currentMarketPriceGold: Double = goldMarketPrices.currentMPOfGold()
    var segConString: String = "ESCLAVA"
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        goldPriceDisplay()
        goldPercentChangeDisplay()
        jewelryPiece.nilChecker()
        
        purchasePrice.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.object(forKey: "jewelryPieceArray") != nil {
            jewelryPiece.jewelryPieceArray = UserDefaults.standard.object(forKey: "jewelryPieceArray") as! Array<jewelryPiece>
        }
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            segConString = "ESCLAVA"
        case 1:
            segConString = "CADENA"
        case 2:
            segConString = "ANILLO" 
        case 3:
            segConString = "ARETES"
        default:
            break
        }
    }
    
    func goldPriceDisplay() {
        let price = currentMarketPriceGold
        let stringPrice = "$" + String(price)
        gpTodayDisplay.text = stringPrice
    }
    
    func goldPercentChangeDisplay() {
        let currentPrice = currentMarketPriceGold
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let yesterdayDateString: String = formatter.string(from: yesterday!)
        let yesterdayPrice = goldMarketPrices.dateMPOfGold(yesterdayDateString)
        let percentChange = goldMarketPrices.percentAdjustViewer(yesterdayPrice, currentPrice)
        var stringPercentChange = String(format: "%.2f", percentChange)
        if currentPrice > yesterdayPrice {
            stringPercentChange = "+" + stringPercentChange + "%"
        }
        else if currentPrice < yesterdayPrice {
            stringPercentChange = stringPercentChange + "%"
        }
        pcTodayDisplay.text = stringPercentChange
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        purchaseDateTxt.inputAccessoryView = toolbar
        purchaseDateTxt.inputView = datePicker
        datePicker.datePickerMode = .date
        
        let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        datePicker.maximumDate = yesterdayDate
    }
    
    
    @objc func donePressed() {
        view.endEditing(true)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        purchaseDateTxt.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    //this function is your main method
    @IBAction func enterTapped(_ sender: Any) {
        view.endEditing(true)
        
        let stringBPDate: String = goldMarketPrices.purchaseDate(purchaseDateTxt.text!)
        let gpBought = goldMarketPrices.dateMPOfGold(stringBPDate)
        let gpToday = currentMarketPriceGold
        let piecePrice = Double(purchasePrice.text!)!
        
        if ((gpBought == 0) || (gpToday == 0)) {
            textView.text = "error encountered with web scrapping values; set to 0"
        }
        else {
            let adjustedPrice = goldMarketPrices.priceAdjust(gpBought, gpToday, piecePrice)
            let adjustedPercent = goldMarketPrices.percentAdjust(gpBought, gpToday)
            
            textView.text = "Precio del oro cuando se compró la pieza: " + String(format: "%.2f", gpBought) + "\nEl precio ajustado por la pieza es: " + String(format: "%.2f", adjustedPrice) + "\nEl cambio porcentual es: " + String(format: "%.2f", adjustedPercent) + "%"
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        view.endEditing(true)
        
        let stringBPDate: String = goldMarketPrices.purchaseDate(purchaseDateTxt.text!)
        let gpBought = goldMarketPrices.dateMPOfGold(stringBPDate)
        let gpToday = currentMarketPriceGold
        let piecePrice = Double(purchasePrice.text!)!
        
        if ((gpBought == 0) || (gpToday == 0)) {
            textView.text = "error encountered with web scrapping values; set to 0"
        }
        else {
            let adjustedPrice = goldMarketPrices.priceAdjust(gpBought, gpToday, piecePrice)
            let adjustedPercent = goldMarketPrices.percentAdjust(gpBought, gpToday)
            
            var tempJImage: UIImage = UIImage()
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                imagePicker.dismiss(animated: true, completion: nil)
                tempJImage = info[.originalImage] as! UIImage
            }
            
            _ = jewelryPiece.init(segConString, stringBPDate, piecePrice, adjustedPrice, gpBought, tempJImage)
            
            textView.text = "Precio del oro cuando se compró la pieza: " + String(format: "%.2f", gpBought) + "\nEl precio ajustado por la pieza es: " + String(format: "%.2f", adjustedPrice) + "\nEl cambio porcentual es: " + String(format: "%.2f", adjustedPercent) + "%"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        purchasePrice.resignFirstResponder()
        purchaseDateTxt.resignFirstResponder()
    }
}

//ADDED: extends the view controller class for textfields, gives many additonal functions
extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

