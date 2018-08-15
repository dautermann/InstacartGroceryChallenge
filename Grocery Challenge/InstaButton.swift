//
//  InstaButton.swift
//  Grocery Challenge
//
//  Created by Michael Dautermann on 7/18/18.
//  Copyright © 2018 Instacart. All rights reserved.
//

import UIKit

class InstaButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override var isSelected: Bool {
        didSet {
            if (isSelected == true) {
                self.backgroundColor = UIColor.gray
            } else {
                self.backgroundColor = UIColor.clear
            }
        }
    }
}
