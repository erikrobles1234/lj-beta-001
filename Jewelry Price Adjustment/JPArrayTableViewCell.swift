//
//  JPArrayTableViewCell.swift
//  Jewelry Price Adjustment
//
//  Created by johnny on 8/11/20.
//  Copyright © 2020 johnny. All rights reserved.
//

import UIKit

class JPArrayTableViewCell: UITableViewCell {
    
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var originalPriceLabel: UILabel!
    @IBOutlet var adjustedPriceLabel: UILabel!
    @IBOutlet var jewelryImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
