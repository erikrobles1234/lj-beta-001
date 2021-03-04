//
//  Page2ViewController.swift
//  Jewelry Price Adjustment
//
//  Created by johnny on 8/8/20.
//  Copyright © 2020 johnny. All rights reserved.
//

import UIKit

class Page2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    /*
        TEST DATA INCASE YOU FUCK SOMETHING UP WITH THE FORKEY
    
        let testTypeData = ["ESCLAVA", "CADENA", "ESCLAVA", "ANILLO", "ARETES"]
        let testDateData = ["09-13-2020", "05-04-2020", "03-29-2019", "04-11-2019", "12-25-2008"]
        let testOrigPriceData = [650.00, 325.00, 780.00, 550.00, 645.00]
        let testAdjPriceData = [780.00, 525.00, 11090.57, 637.00, 810.00]
    */
    
    var jewelryPieceData: Array<jewelryPiece> = jewelryPiece.jewelryPieceArray
    
    var typeData: Array<String> = Array()
    var dateData: Array<String> = Array()
    var origPriceData: Array<Double> = Array()
    var adjPriceData: Array<Double> = Array()
    var origGoldPriceData: Array<Double> = Array()
    var imageData: Array<UIImage> = Array()
    
    // 
    func arraySplitter(_ jewelryArray: Array<jewelryPiece>) {
        for x in 0...jewelryArray.count - 1 {
            typeData.append(jewelryArray[x].returnType())
            dateData.append(jewelryArray[x].returnDatePurchased())
            origPriceData.append(jewelryArray[x].returnOriginalPrice())
            adjPriceData.append(jewelryArray[x].returnCurrentPrice())
            origGoldPriceData.append(jewelryArray[x].returnOriginalGoldPrice())
            imageData.append(jewelryArray[x].returnImage())
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        arraySplitter(jewelryPieceData)
        let nib = UINib(nibName: "JPArrayTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "JPArrayTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // Number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return jewelryPieceData.count
    }
    
    // Creates a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JPArrayTableViewCell", for: indexPath) as! JPArrayTableViewCell
        cell.typeLabel.text = self.typeData[indexPath.row]
        cell.dateLabel.text = self.dateData[indexPath.row]
        cell.originalPriceLabel.text = String(self.origPriceData[indexPath.row])
        cell.adjustedPriceLabel.text = String(self.adjPriceData[indexPath.row])
        cell.jewelryImageView.image = self.imageData[indexPath.row]
        return cell
    }
    
    // Deletes row along with erasure of accompanying data from database
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            jewelryPiece.jewelryPieceArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
