//
//  DataController.swift
//  RoofCalculationTest
//
//  Created by Andrey Stecenko on 3/20/20.
//  Copyright © 2020 Andrey Stecenko. All rights reserved.
//

import Foundation
import UIKit

protocol DataControllerDelegate {
    func dataSourseChanged(dataSourse: [Roof]?, error: Error?)
}

enum RoofType: Int {
    case odnoskat = 1
    case dviskat = 2
    case mansarda = 3
    case valmova = 4
    case shatrovaya = 5
}

enum SegueIDs: String {
    case CalculateScreenSegue
    case ResultScreenSegue
}

// объявляем глобальную переменнную
var dataCurrentRoof: [Roof] {
    
    let imageType = [UIImage(named: "odnoskat"),
                     UIImage(named: "dviskat"),
                     UIImage(named: "mansarda"),
                     UIImage(named: "valmova"),
                     UIImage(named: "shatrovaya")]
    
    let imageData = [UIImage(named: "odnoskat_data"),
                     UIImage(named: "dviskat_data"),
                     UIImage(named: "mansarda_data"),
                     UIImage(named: "valmova_data"),
                     UIImage(named: "shatrovaya_data")]
    
    let textLabel = ["Односкатная", "Двускатная", "Мансардная", "Вальмовая", "Шатровая"]
    
    let textData = [["X", "L"],
                    ["X", "L1", "L2"],
                    ["X", "L1", "L2", "L3", "L4"],
                    ["X1", "X2", "X3", "L1", "L2", "L3", "L4"],
                    ["X1", "X2", "L"]]
    
    let tempArray = [Roof(imageType: imageType[0], imageData: imageData[0], textLabel: textLabel[0], textData: textData[0]),
                     Roof(imageType: imageType[1], imageData: imageData[1], textLabel: textLabel[1], textData: textData[1]),
                     Roof(imageType: imageType[2], imageData: imageData[2], textLabel: textLabel[2], textData: textData[2]),
                     Roof(imageType: imageType[3], imageData: imageData[3], textLabel: textLabel[3], textData: textData[3]),
                     Roof(imageType: imageType[4], imageData: imageData[4], textLabel: textLabel[4], textData: textData[4])]
    
    return tempArray
}

class DataController: NSObject {
    
    var delegate: DataControllerDelegate?
    var tempArray: [String] = []
    var dataArray: [Double] = []
    
    var result = [(String, String)]()
    var errorString: String = ""
    var error: Bool = false {
        didSet {
            if error == false {
                self.errorString = ""
            }
        }
    }
    
    //основная функция расчета
    public func calculate(roofType: RoofType) -> Bool {
        
        self.result.removeAll()
        self.error = false
        
        switch roofType {
        // Односкатная
        case .odnoskat:
            if dataArray.count >= dataCurrentRoof[0].textData.count {
                let x = dataArray[0]
                let l = dataArray[1]
                
                if x == 0 || l == 0 {
                    self.error = true
                    self.errorString = "Не все параметры введены"
                } else {
                    let square_ = x * l
                    let torceva_ = (l * 2) + x
                    let kapelnik_ = x
                    let snegoderzhatel_ = x
                    let samorez_ = Int(min(square_ * 10, Double(Int.max)))
                    
                    self.addToResultOdnoskat(square: square_, torceva: torceva_, kapelnik: kapelnik_, snegoderzhatel: snegoderzhatel_, samorez: samorez_)
                }
            } else {
                self.error = true
                self.errorString = "Не все параметры введены"
            }
            
            break
        // Двускатная
        case .dviskat:
            if dataArray.count >= dataCurrentRoof[1].textData.count {
                let x = dataArray[0]
                let l1 = dataArray[1]
                let l2 = dataArray[2]
                
                if x == 0 || l1 == 0 || l2 == 0 {
                    self.error = true
                    self.errorString = "Не все параметры введены"
                } else {
                    let square_ = (l1 + l2) * x
                    let konek_ = x
                    let torceva_ = (l1 + l2) * 2
                    let kapelnik_ = x * 2
                    let snegoderzhatel_ = x * 2
                    let samorez_ = Int(min(square_ * 10, Double(Int.max)))
                    
                    self.addToResultDviskat(square: square_, konek: konek_, torceva: torceva_, kapelnik: kapelnik_, snegoderzhatel: snegoderzhatel_, samorez: samorez_)
                }
            } else {
                self.error = true
                self.errorString = "Не все параметры введены"
            }
            
            break
        // Мансардная
        case .mansarda:
            if dataArray.count >= dataCurrentRoof[2].textData.count {
                let x = dataArray[0]
                let l1 = dataArray[1]
                let l2 = dataArray[2]
                let l3 = dataArray[3]
                let l4 = dataArray[4]
                
                if x == 0 || l1 == 0 || l2 == 0 || l3 == 0 || l4 == 0 {
                    self.error = true
                    self.errorString = "Не все параметры введены"
                } else {
                    let square_ = (l1 + l2 + l3 + l4) * x
                    let konek_ = x
                    let torceva_ = (l1 + l2 + l3 + l4) * 2
                    let kapelnik_ = x * 2
                    let perelom_ = x * 2
                    let snegoderzhatel_ = x * 2
                    let samorez_ = Int(min(square_ * 10, Double(Int.max)))
                    
                    self.addToResultMansarda(square: square_, konek: konek_, torceva: torceva_, kapelnik: kapelnik_, perelom: perelom_, snegoderzhatel: snegoderzhatel_, samorez: samorez_)
                }
            } else {
                self.error = true
                self.errorString = "Не все параметры введены"
            }
            
            break
        // Вальмовая
        case .valmova:
            if dataArray.count >= dataCurrentRoof[3].textData.count {
                let x1 = dataArray[0]
                let x2 = dataArray[1]
                let x3 = dataArray[2]
                let l1 = dataArray[3]
                let l2 = dataArray[4]
                let l3 = dataArray[5]
                let l4 = dataArray[6]
                
                if x1 == 0 || x2 == 0 || x3 == 0 || l1 == 0 || l2 == 0 || l3 == 0 || l4 == 0 {
                    self.error = true
                    self.errorString = "Не все параметры введены"
                } else {
//                    let square_ = (l1 + l2) * x
//                    let konek_ = x
//                    let torceva_ = (l1 + l2) * 2
//                    let kapelnik_ = x * 2
//                    let perelom_ = x * 2
//                    let snegoderzhatel_ = x * 2
//                    let samorez_ = Int(min(square_ * 10, Double(Int.max)))
//
//                    self.addToResultMansarda(square: square_, konek: konek_, torceva: torceva_, kapelnik: kapelnik_, perelom: perelom_, snegoderzhatel: snegoderzhatel_, samorez: samorez_)
                }
            } else {
                self.error = true
                self.errorString = "Не все параметры введены"
            }
            
            break
        // Шатровая
        default :
            //.shatrovaya
            //addToResultShatrovaya(square: <#T##Double#>, konek: <#T##Double#>, planka: <#T##Double#>, samorez: <#T##Int#>)
            break
        }
        
        return false
    }
    
    // Add methods
    
    // odnoskat
    private func addToResultOdnoskat(square: Double, torceva: Double, kapelnik: Double, snegoderzhatel: Double, samorez: Int) {
        self.result.append(("Кровля", "\(square.format(f: ".2")) м²"))
        self.result.append(("Торцевая планка", "\(torceva.format(f: ".2")) м"))
        self.result.append(("Капельник", "\(kapelnik.format(f: ".2")) м"))
        self.result.append(("Снегодержатель", "\(snegoderzhatel.format(f: ".2")) м"))
        self.result.append(("Саморезы", "\(samorez) шт"))
    }
    
    // dviskat
    func addToResultDviskat(square: Double, konek: Double, torceva: Double, kapelnik: Double, snegoderzhatel: Double, samorez: Int) {
        self.result.append(("Кровля", "\(square.format(f: ".2")) м²"))
        self.result.append(("Конек", "\(konek.format(f: ".2")) м"))
        self.result.append(("Торцевая планка", "\(torceva.format(f: ".2")) м"))
        self.result.append(("Капельник", "\(kapelnik.format(f: ".2")) м"))
        self.result.append(("Снегодержатель", "\(snegoderzhatel.format(f: ".2")) м"))
        self.result.append(("Саморезы", "\(samorez) шт"))
    }
    
    // mansarda
    func addToResultMansarda(square: Double, konek: Double, torceva: Double, kapelnik: Double, perelom: Double, snegoderzhatel: Double, samorez: Int) {
        self.result.append(("Кровля", "\(square.format(f: ".2")) м²"))
        self.result.append(("Конек", "\(konek.format(f: ".2")) м"))
        self.result.append(("Торцевая планка", "\(torceva.format(f: ".2")) м"))
        self.result.append(("Капельник", "\(kapelnik.format(f: ".2")) м"))
        self.result.append(("Планка перелома", "\(perelom.format(f: ".2")) м"))
        self.result.append(("Снегодержатель", "\(snegoderzhatel.format(f: ".2")) м"))
        self.result.append(("Саморезы", "\(samorez) шт"))
    }
    
    // valmova
    func addToResultValmova(square: Double, konek: Double, planka: Double, samorez: Int) {
        self.result.append(("Кровля", "\(square.format(f: ".2")) м²"))
        self.result.append(("Конек", "\(konek.format(f: ".2")) м"))
        self.result.append(("Торцевая планка", "\(planka.format(f: ".2")) м"))
        self.result.append(("Саморезы", "\(samorez) шт"))
    }
    
    // shatrovaya
    func addToResultShatrovaya(square: Double, konek: Double, planka: Double, samorez: Int) {
        self.result.append(("Кровля", "\(square.format(f: ".2")) м²"))
        self.result.append(("Конек", "\(konek.format(f: ".2")) м"))
        self.result.append(("Торцевая планка", "\(planka.format(f: ".2")) м"))
        self.result.append(("Саморезы", "\(samorez) шт"))
    }
    
}


// MARK: - Extensions

extension DataController: CalculateDataCellDelegate {
    
    // MARK: - CalculateDataCellDelegate
    
    func calculateDataCell(_ cell: CalculateDataTableViewCell, didChange text: String) {
        self.tempArray.append(text)
    }
    
}
