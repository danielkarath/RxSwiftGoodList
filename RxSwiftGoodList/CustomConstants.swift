//
//  CustomConstants.swift
//  RxSwiftGoodList
//
//  Created by Daniel Karath on 5/20/23.
//

import Foundation
import UIKit

struct CustomConstants {
    static let backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1.0)
    static let contentBackgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
    static let basicFontColor =  UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
    static let secondaryFontColor =  UIColor(red: 120/255, green: 120/255, blue: 120/255, alpha: 1.0)
   
    public static func setFont(fontSize: CGFloat, isBold: Bool) -> UIFont {
        if isBold {
            return UIFont(name: "Kailasa Bold", size: fontSize)!
        } else {
            return UIFont(name: "Kailasa Regular", size: fontSize)!
        }
    }
}
