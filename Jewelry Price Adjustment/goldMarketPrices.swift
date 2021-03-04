//
//  goldMarketPrices.swift
//  Jewelry Price Adjustment
//
//  Created by johnny on 8/10/20.
//  Copyright © 2020 johnny. All rights reserved.
//

import UIKit
import SwiftSoup

class goldMarketPrices {
/*
     LAZY BULLSHIT ALERT: MUST FIX LATER
        Decided that whatever class can call on this class and hardcode a value to these variables. I can tell this will not end well.
     */
    
//converts input date from user into usable strings/doubles
    static func purchaseDate(_ purchaseDateInput: String) -> String {
        let characters = Array(purchaseDateInput)
        var purchaserDateArray = [Character]()
        for x in 0...9 {
            purchaserDateArray.append(characters[x])
        }
        let purchaseDate = String(purchaserDateArray)
        return purchaseDate
    }

//scrapes url for CURRENT MARKET gold price; stores it in this class
   static func currentMPOfGold() -> Double {
        let url = URL(string: "https://www.apmex.com/gold-price")
            do {
                let html = try String(contentsOf: url!, encoding: String.Encoding.ascii)
                let doc: Document = try SwiftSoup.parse(html)
                let priceHtml: Element? = try doc.select("p.price").first()
                let priceString = String(describing: priceHtml)
                print(priceString)
                
                let set = CharacterSet(charactersIn: ".0123456789")
                let stripped = priceString.components(separatedBy: set.inverted).joined()
                let curPriceOfGold = (stripped as NSString).doubleValue
                return curPriceOfGold
            } catch {
                // contents could not be loaded
                print("contents could not be loaded")
                return 999999999
            }
    }
    
//scrapes url for DATE MARKET gold price
    static func dateMPOfGold(_ date: String) -> Double {
        let url = URL(string: "https://goldprice.org/gold-price-today/" + date)
            do {
                let html = try String(contentsOf: url!, encoding: String.Encoding.ascii)
                let doc: Document = try SwiftSoup.parse(html)
                let priceHtml: Element? = try doc.select("td.text-right").first()
                let priceString = String(describing: priceHtml)
                print(priceString)
                
                let set = CharacterSet(charactersIn: ".0123456789")
                let stripped = priceString.components(separatedBy: set.inverted).joined()
                let curPriceOfGold = (stripped as NSString).doubleValue
                print(curPriceOfGold)
                return curPriceOfGold
            } catch {
                // contents could not be loaded
                print("contents could not be loaded")
                return 0.0
            }
    }

//adjusts price of gold piece, return adjusted price
    static func priceAdjust(_ gPriceBought: Double, _ gPriceToday: Double, _ piecePrice: Double) -> Double {
        if gPriceBought >= gPriceToday {
            return piecePrice
        }
        else {
            var percentAdjust = gPriceToday - gPriceBought
            percentAdjust = (percentAdjust / gPriceBought) + 1
            let jewelryPrice = piecePrice * percentAdjust
            return jewelryPrice
        }
    }
    
//only calculates the percentage of adjustment, returns that value
    static func percentAdjust(_ gPriceBought: Double, _ gPriceToday: Double) -> Double {
        if gPriceBought >= gPriceToday {
            return 0.0
        }
        else {
            var percentAdjust = gPriceToday - gPriceBought
            percentAdjust = (percentAdjust / gPriceToday) * 100
            return percentAdjust
        }
    }
    
//modified percent adjust specifically for the top current value display
    static func percentAdjustViewer(_ gPriceBought: Double, _ gPriceToday: Double) -> Double {
        var percentAdjust = gPriceToday - gPriceBought
        percentAdjust = (percentAdjust / gPriceToday) * 100
        return percentAdjust
    }
}

            
