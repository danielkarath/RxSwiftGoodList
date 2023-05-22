//
//  AddTaskView.swift
//  RxSwiftGoodList
//
//  Created by Daniel Karath on 5/20/23.
//

import UIKit

protocol AddTaskViewDelegate: AnyObject {
    func didSaveTask()
    func cancelTask()
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
        segmentedControl.font(name: "Kailasa Regular", size: 11, normalColor: .black, selectedColor: .systemBlue)
        segmentedControl.tintColor = CustomConstants.textColor
        segmentedControl.frame.size = CGSize(width: 200, height: 32)
        segmentedControl.subviews.forEach { subview in
          subview.backgroundColor = CustomConstants.contentBackgroundColor
        }
        segmentedControl.backgroundColor = CustomConstants.contentBackgroundColor
        return segmentedControl
    }()
    
    private let taskTitleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add a title to your task"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = CustomConstants.setFont(fontSize: 12, isBold: false)
        label.textColor = CustomConstants.textColor
        return label
    }()
    
    private let taskTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = CustomConstants.contentBackgroundColor
        textView.layer.cornerRadius = 8
        return textView
    }()
    
    private let saveTaskButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame.size = CGSize(width: UIScreen.main.bounds.width-64, height: 44)
        button.layer.cornerRadius = 8
        button.setTitleColor(CustomConstants.contentBackgroundColor, for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = CustomConstants.setFont(fontSize: 11, isBold: true)
        button.setTitle("Save", for: .normal)
        button.setTitle("Save", for: .highlighted)
        button.layer.zPosition = 6
        return button
    }()
    
    private let cancelTaskButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame.size = CGSize(width: 50, height: 32)
        button.layer.cornerRadius = 8
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .clear.withAlphaComponent(0.0)
        button.titleLabel?.font = CustomConstants.setFont(fontSize: 11, isBold: false)
        button.setTitle("Cancel", for: .normal)
        button.setTitle("Cancel", for: .highlighted)
        button.layer.zPosition = 6
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = CustomConstants.backgroundColor
        setupConstraints()
        taskTextView.becomeFirstResponder()
        saveTaskButton.addTarget(self, action: #selector(saveTaskButtonTapped(_:)), for: .touchUpInside)
        cancelTaskButton.addTarget(self, action: #selector(cancelTaskButtonTapped(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubviews(titleLabel, priorityLabel, segmentedControl, saveTaskButton, taskTitleDescriptionLabel, taskTextView, cancelTaskButton)
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
            
            taskTitleDescriptionLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 24),
            taskTitleDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            taskTitleDescriptionLabel.heightAnchor.constraint(equalToConstant: 24),
            taskTitleDescriptionLabel.widthAnchor.constraint(equalToConstant: 180),
            
            taskTextView.topAnchor.constraint(equalTo: taskTitleDescriptionLabel.bottomAnchor, constant: -2),
            taskTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            taskTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            taskTextView.heightAnchor.constraint(equalToConstant: 128),
            
            saveTaskButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            saveTaskButton.heightAnchor.constraint(equalToConstant: 44),
            saveTaskButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            saveTaskButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            cancelTaskButton.widthAnchor.constraint(equalToConstant: 60),
            cancelTaskButton.heightAnchor.constraint(equalToConstant: 32),
            cancelTaskButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            cancelTaskButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ])
    }
    
    @objc
    private func saveTaskButtonTapped(_ sender: UIButton) {
        delegate?.didSaveTask()
    }
    
    @objc
    private func cancelTaskButtonTapped(_ sender: UIButton) {
        delegate?.cancelTask()
    }

}
