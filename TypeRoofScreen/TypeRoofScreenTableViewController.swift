//
//  TypeRoofScreenTableViewController.swift
//  RoofCalculationTest
//
//  Created by Andrey Stecenko on 3/16/20.
//  Copyright © 2020 Andrey Stecenko. All rights reserved.
//

import UIKit

class TypeRoofScreenTableViewController: UITableViewController {

    private var roofToSelect: UIImage? = nil
    private var currentForm: Int? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCurrentRoof.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TypeOfRoofTableViewCell", for: indexPath) as? TypeOfRoofTableViewCell {
            let roofLabel = dataCurrentRoof[indexPath.row].textLabel
            cell.nameLabel.text = roofLabel
            
            let roofImage = dataCurrentRoof[indexPath.row].imageType
            cell.picture.image = roofImage

            return cell
        }
        
        return UITableViewCell()
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let roofIndex = indexPath.row
        
        guard roofIndex < dataCurrentRoof.count else {
            return
        }
        
        roofToSelect = dataCurrentRoof[roofIndex].imageData
        currentForm = roofIndex + 1
        
        performSegue(withIdentifier: SegueIDs.CalculateScreenSegue.rawValue, sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIDs.CalculateScreenSegue.rawValue, let calculateScreenVC = segue.destination as? CalculateScreenTableViewController {
            calculateScreenVC.roofImageToDisplay = roofToSelect
            calculateScreenVC.currentRoofForm = currentForm
        }
    }
    
}
