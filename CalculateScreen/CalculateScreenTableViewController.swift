//
//  CalculateScreenTableViewController.swift
//  RoofCalculationTest
//
//  Created by Andrey Stecenko on 3/16/20.
//  Copyright © 2020 Andrey Stecenko. All rights reserved.
//

import UIKit

class CalculateScreenTableViewController: UITableViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var roofImageView: UIImageView!
    
    
    // MARK: - Properties
    
    let cellIdentifier = "CalculateDataTableViewCell"
    let dataController = DataController()
    
    var roofImageToDisplay: UIImage!
    var currentRoofForm: Int!
    var currentRoofType: RoofType!
    var calculateDataTableViewCell: CalculateDataTableViewCell!
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tempImage = roofImageToDisplay {
            roofImageView.image = tempImage
        } else {
            roofImageView.image = UIImage()
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func countButtonAction(_ sender: Any) {
        
        self.view.endEditing(true)
        
        if dataController.calculate(roofType: currentRoofType) {
            self.showErrorWarning(dataController.errorString)
        } else {
            if dataController.result.count > 0 {
                performSegue(withIdentifier: SegueIDs.ResultScreenSegue.rawValue, sender: nil)
            } else {
                self.showErrorWarning(dataController.errorString)
            }
        }
        
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch currentRoofForm {
        case 0:
            self.currentRoofType = .odnoskat
            break
        case 1:
            self.currentRoofType = .dviskat
            break
        case 2:
            self.currentRoofType = .mansarda
            break
        case 3:
            self.currentRoofType = .valmova
            break
        default:
            self.currentRoofType = .shatrovaya
            break
        }
        
        var number = dataCurrentRoof[currentRoofForm].textData.count
        number = 1 + number + 1
        
        return number
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CalculateDataTableViewCell
            
            cell.dataLabel.isHidden = true
            cell.equalLabel.isHidden = true
            cell.unitLabel.isHidden = true
            cell.dataTextField.isHidden = true
            cell.countButton.isHidden = true
            cell.contentView.backgroundColor = UIColor.green
            
            return cell
        case 1...dataCurrentRoof[currentRoofForm].textData.count:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CalculateDataTableViewCell
            
            let dataLabel = dataCurrentRoof[currentRoofForm].textData[indexPath.row - 1]
            cell.dataLabel.text = dataLabel
            
            // let textFieldTag = indexPath.row
            // cell.dataTextField.tag = textFieldTag
            // cell.dataTextField.text = "0.00"
            cell.dataTextField.placeholder = "0.00"
            cell.dataTextField.delegate = self
            
            return cell
        case dataCurrentRoof[currentRoofForm].textData.count + 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CalculateDataTableViewCell
            
            cell.dataLabel.isHidden = true
            cell.equalLabel.isHidden = true
            cell.unitLabel.isHidden = true
            cell.dataTextField.isHidden = true
            cell.countButton.isHidden = false
            
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    
    // MARK: - UITableViewDelegate
    
    // сделаем так что после появления ячейки внизу не будет лишних видимых ячеек (сетки). Добавим два метода Футера.
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultVC = segue.destination as? ResultScreenViewController {
            if segue.identifier == SegueIDs.ResultScreenSegue.rawValue {
                resultVC.dataController = self.dataController
                //
            }
        }
    }
    
}


// MARK: - Extensions

extension CalculateScreenTableViewController: UITextFieldDelegate {
    
    // MARK: Text fields delegete
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if (textField.text! as NSString).doubleValue == 0.0 {
            
            textField.text = ""
        }
        
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let rr = textField.text! as NSString
        
        textField.text = rr.replacingOccurrences(of: ",", with: ".")
        
        if (textField.text! as NSString).doubleValue != 0 {
            let newValue = (textField.text! as NSString).doubleValue
            if newValue > 999 {
                self.showErrorWarning("Параметр не может превышать 999")
                textField.text = "999.00"
            } else {
                textField.text = (textField.text! as NSString).doubleValue.format(f: ".2")
            }
            
        } else {
            textField.text  = "0.00"
        }
        
        setTextFieldToValue(textField: textField, type: currentRoofType)
        
    }
    
    // move to the next UITextField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newLength = NSString(string: textField.text!).length + NSString(string: string).length - range.length
        if newLength > 6 {
            return false
        } else {
            return true
        }
    }
    
    
    //Выделение всего в ячейке перед редактированием
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
    }
    
    //Запись значения в переменку по тэгу
    private func setTextFieldToValue(textField: UITextField, type: RoofType) {
        
        switch type {
        case .odnoskat:
            dataController.dataArray.append(textField.numbericValue())
            break
        case .dviskat:
            dataController.dataArray.append(textField.numbericValue())
            break
        case .mansarda:
            dataController.dataArray.append(textField.numbericValue())
            break
        case .valmova:
            dataController.dataArray.append(textField.numbericValue())
            break
            
        default:
            dataController.dataArray.append(textField.numbericValue())
            break
        }
        
    }
    
}
