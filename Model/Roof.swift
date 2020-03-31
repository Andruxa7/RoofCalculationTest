//
//  Roof.swift
//  RoofCalculationTest
//
//  Created by Andrey Stecenko on 3/21/20.
//  Copyright © 2020 Andrey Stecenko. All rights reserved.
//

import Foundation
import UIKit

public struct Roof {
    
    public var imageType: UIImage?
    public var imageData: UIImage?
    public var textLabel: String
    public var textData: [String]
    
    init(imageType: UIImage?, imageData: UIImage?, textLabel: String, textData: [String]) {
        self.imageType = imageType
        self.imageData = imageData
        self.textLabel = textLabel
        self.textData = textData
    }
    
}
