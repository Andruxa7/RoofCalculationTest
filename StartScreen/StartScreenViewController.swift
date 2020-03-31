//
//  StartScreenViewController.swift
//  RoofCalculationTest
//
//  Created by Andrey Stecenko on 3/16/20.
//  Copyright © 2020 Andrey Stecenko. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var chooseButton: UIButton!
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ""
        self.setTitle(title: "Расчёт кровли", aligment: .center)

        chooseButton.layer.cornerRadius = 7.0
        chooseButton.layer.shadowRadius = 1.0
        chooseButton.layer.shadowOpacity = 0.6
        chooseButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    }

}
