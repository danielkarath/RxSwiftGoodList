//
//  AddTaskView.swift
//  RxSwiftGoodList
//
//  Created by Daniel Karath on 5/20/23.
//

import UIKit

protocol AddTaskViewDelegate: AnyObject {
    func didSaveTask()
}

class AddTaskView: UIView {

    public weak var delegate: AddTaskViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add New Task"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = CustomConstants.setFont(fontSize: 16, isBold: true)
        label.textColor = CustomConstants.textColor
        return label
    }()
    
    private let priorityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Set the task priority"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = CustomConstants.setFont(fontSize: 12, isBold: false)
        label.textColor = CustomConstants.textColor
        return label
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["All", "High", "Normal", "Low"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.font(name: "Kailasa Regular", size: 11)
        segmentedControl.tintColor = CustomConstants.textColor
        segmentedControl.frame.size = CGSize(width: 200, height: 32)
        segmentedControl.subviews.forEach { subview in
          subview.backgroundColor = CustomConstants.contentBackgroundColor
        }
        segmentedControl.backgroundColor = CustomConstants.contentBackgroundColor
        return segmentedControl
    }()
    
    private let saveTaskButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame.size = CGSize(width: 60, height: 32)
        button.layer.cornerRadius = 8
        button.setTitleColor(CustomConstants.contentBackgroundColor, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = CustomConstants.setFont(fontSize: 11, isBold: true)
        button.setTitle("Save", for: .normal)
        button.setTitle("Save", for: .highlighted)
        button.layer.zPosition = 6
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = CustomConstants.backgroundColor
        setupConstraints()
        saveTaskButton.addTarget(self, action: #selector(saveTaskButtonTapped(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubviews(titleLabel, priorityLabel, segmentedControl, saveTaskButton)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            titleLabel.widthAnchor.constraint(equalToConstant: 180),
            
            priorityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            priorityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            priorityLabel.heightAnchor.constraint(equalToConstant: 24),
            priorityLabel.widthAnchor.constraint(equalToConstant: 180),
            
            segmentedControl.topAnchor.constraint(equalTo: priorityLabel.bottomAnchor, constant: -2),
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            segmentedControl.widthAnchor.constraint(equalToConstant: 180),
            segmentedControl.heightAnchor.constraint(equalToConstant: 32),
            
            saveTaskButton.widthAnchor.constraint(equalToConstant: 60),
            saveTaskButton.heightAnchor.constraint(equalToConstant: 32),
            saveTaskButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            saveTaskButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ])
    }
    
    @objc
    private func saveTaskButtonTapped(_ sender: UIButton) {
        delegate?.didSaveTask()
    }

}
