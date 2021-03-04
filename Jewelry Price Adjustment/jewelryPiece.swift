//
//  jewelryPiece.swift
//  Jewelry Price Adjustment
//
//  Created by johnny on 8/8/20.
//  Copyright © 2020 johnny. All rights reserved.
//

import UIKit

struct jewelryPiece {
    var type: String = "nil"
    var datePurchased: String = "0000-00-00"
    var originalPrice: Double = 0.0
    var currentPrice: Double = 0.0
    var originalGoldPrice: Double = 0.0
    var jewelryImage: UIImage
    
    static var jewelryPieceArray: Array<jewelryPiece> = Array()
    static var typeArray: Array<String> = Array()
    static var dateArray: Array<String> = Array()
    static var origPriceArray: Array<Double> = Array()
    static var adjPriceArray: Array<Double> = Array()
    static var origGoldPrice: Array<Double> = Array()
    
    static func nilChecker() {
        if UserDefaults.standard.object(forKey: "jewelryPieceArray") != nil {
            jewelryPiece.jewelryPieceArray = UserDefaults.standard.object(forKey: "jewelryPieceArray") as! Array<jewelryPiece>
        }
    }

    
    init(_ type: String, _ datePurchased: String, _ originalPrice: Double, _ currentPrice: Double, _ originalGoldPrice: Double, _ jewelryImage: UIImage) {
        self.type = type
        self.datePurchased = datePurchased
        self.originalPrice = originalPrice
        self.currentPrice = currentPrice
        self.originalGoldPrice = originalGoldPrice
        self.jewelryImage = jewelryImage
        jewelryPiece.jewelryPieceArray.append(self)
        do {
            var encodedData = try NSKeyedArchiver.archivedData(withRootObject: jewelryPiece.jewelryPieceArray, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedData, forKey: "jewelryPieceArray")
        } catch {
            print("critical failure")
        }
    }
    
    func returnType() -> String{
        return type
    }
    
    func returnDatePurchased() -> String{
        return datePurchased
    }
    
    func returnOriginalPrice() -> Double {
        return originalPrice
    }
    
    func returnCurrentPrice() -> Double {
        return currentPrice
    }
    
    func returnOriginalGoldPrice() -> Double {
        return originalGoldPrice
    }
    
    func returnImage() -> UIImage {
        return jewelryImage
    }
    
}
