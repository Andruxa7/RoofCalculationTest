//
//  ResultScreenViewController.swift
//  RoofCalculationTest
//
//  Created by Andrey Stecenko on 3/23/20.
//  Copyright © 2020 Andrey Stecenko. All rights reserved.
//

import UIKit

class ResultScreenViewController: UIViewController {
    
    enum Identifire: String {
        case HeaderCell
        case ResultCell
    }
    
    // MARK: - Properties
    
    var dataController: DataController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Extension

extension ResultScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1 + dataController.result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: Identifire.HeaderCell.rawValue, for: indexPath) as! HeaderTableViewCell

                    return cell

                case 1...dataController.result.count:
                    let cell = tableView.dequeueReusableCell(withIdentifier: Identifire.ResultCell.rawValue, for: indexPath) as! ResultTableViewCell

                    cell.nameLabel.text = dataController.result[indexPath.row - 1].0
                    cell.amountLabel.text = "\(dataController.result[indexPath.row - 1].1)"

                    return cell

                default:
                    return UITableViewCell()
                }

    }
    
    
    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 110
//        case 1...ASDataForCalculations.result.count:
//            return 44
        default:
            return 44
        }
    }
    
}

