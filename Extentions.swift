//
//  Extentions.swift
//  RoofCalculationTest
//
//  Created by Andrey Stecenko on 3/19/20.
//  Copyright © 2020 Andrey Stecenko. All rights reserved.
//

import Foundation
import UIKit

//Округление
func roundToNSigns(x: Double, toSigns: Int) -> Double {

    let y = Double(pow(10.0, Double(toSigns)))

    return Double(lroundf(Float(y) * Float(x)))/y
}

//===================================================================================================================================================

extension Int {
    func asDouble() -> Double {
        return Double(self)
    }
}

//===================================================================================================================================================

extension UIViewController {
    
    func setTitle(title:String, aligment: NSTextAlignment) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.text = title
        label.textAlignment = aligment

        self.navigationItem.titleView = label
    }

    @objc func goBack() {
        let _ = navigationController?.popViewController(animated: true)
    }

    func showErrorWarning(_ msg: String) {
        let alert  = UIAlertController(title: "Внимание!", message: "\(msg)", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)

        alert.addAction(okAction)

        self.present(alert, animated: true, completion: nil)
    }
    
}

//=================================================================================================================================================
extension UITextField {

    func setNumbericFromText() {
        var newValue = 0.0
        
        if let temp1 = self.text {
            if let temp = Double(temp1) {
                newValue = roundToNSigns(x: temp, toSigns: 2)
            }
        }

        if newValue == 0 {
            self.text = "0.00"
        } else {
            self.text = "\(Double(newValue).format(f: ".2"))"
        }

    }

    func setNumbricValue(_ newValue:Double) {

        if newValue == 0 {
            self.text = "0.00"
        } else {
            self.text = Double(newValue).format(f: ".2")
        }

    }

    func setIntNumbricValue(_ newValue:Double) {

        if newValue==0 {
            self.text = "0"
        } else {
            self.text = Double(newValue).format(f: ".0")
        }

    }

    func numbericValue()->Double {
        var value = 0.0
        if let temp1 = self.text {
            if let temp = Double(temp1) {
                value = roundToNSigns(x: temp, toSigns: 2)
            }
        }
        return value
    }

    func numbericIntValue()->Int {
        var value = 0.0
        if let temp1 = self.text {
            if let temp = Double(temp1) {
                value = roundToNSigns(x: temp, toSigns: 0)
            }
        }
        return Int(value)
    }

}

//===================================================================================================================================================

extension Int {
    func format(f: String) -> String {
        return String(format: "%\(f)d", self)
    }
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

extension Float {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
