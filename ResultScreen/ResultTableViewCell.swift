//
//  ResultTableViewCell.swift
//  RoofCalculationTest
//
//  Created by Andrey Stecenko on 3/23/20.
//  Copyright © 2020 Andrey Stecenko. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
