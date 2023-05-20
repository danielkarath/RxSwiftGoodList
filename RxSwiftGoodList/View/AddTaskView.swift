//
//  AddTaskView.swift
//  RxSwiftGoodList
//
//  Created by Daniel Karath on 5/20/23.
//

import UIKit

class AddTaskView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = CustomConstants.backgroundColor
        //setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubviews()
        NSLayoutConstraint.activate([
            
        ])
    }

}
