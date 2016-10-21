//
//  UILabel+Common.swift
//  TestKitchen
//
//  Created by 王健旭 on 2016/10/21.
//  Copyright © 2016年 王健旭. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {

    class func createLabel(text: String?,textAlignment: NSTextAlignment?, font: UIFont?)->UILabel {

        let label = UILabel()
        
        if let tmpText = text {
            label.text = tmpText
        }

        if let tmpAlignment = textAlignment {
            label.textAlignment = tmpAlignment
        }

        if let tmpFont = font {
            label.font = tmpFont
        }

        return label

    }

}






