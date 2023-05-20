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
