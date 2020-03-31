//
//  CalculateDataTableViewCell.swift
//  RoofCalculationTest
//
//  Created by Andrey Stecenko on 3/18/20.
//  Copyright © 2020 Andrey Stecenko. All rights reserved.
//

import UIKit

protocol CalculateDataCellDelegate: class {
   func calculateDataCell(_ cell: CalculateDataTableViewCell, didChange text: String)
}

class CalculateDataTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var equalLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var countButton: UIButton!
    
    
    // MARK: - Properties
    
    weak var delegate: CalculateDataCellDelegate?
    

    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    // MARK: - IBActions
    
    @IBAction func textChanged(_ sender: UITextField) {
        delegate?.calculateDataCell(self, didChange: dataTextField.text ?? "")
    }

}

