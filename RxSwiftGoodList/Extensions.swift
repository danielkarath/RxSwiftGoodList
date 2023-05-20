//
//  Extensions.swift
//  RxSwiftGoodList
//
//  Created by Daniel Karath on 5/20/23.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach ({
            addSubview($0)
        })
    }
}

extension UISegmentedControl {
    func font(name: String?, size: CGFloat?, normalColor: UIColor, selectedColor: UIColor) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: name ?? "", size: size ?? 0.0) as Any,
            .foregroundColor: normalColor
        ]
        setTitleTextAttributes(attributes, for: .normal)
        
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: name ?? "", size: size ?? 0.0) as Any,
            .foregroundColor: selectedColor
        ]
        setTitleTextAttributes(selectedAttributes, for: .selected)
    }
}
