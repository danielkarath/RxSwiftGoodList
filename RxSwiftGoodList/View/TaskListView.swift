//
//  TaskListView.swift
//  RxSwiftGoodList
//
//  Created by Daniel Karath on 5/20/23.
//

import UIKit

protocol TaskListViewDelegate: AnyObject {
    func didAddNewTask()
}

class TaskListView: UIView {
    
    public weak var delegate: TaskListViewDelegate?
    
    private var tableView: UITableView?
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["All", "High", "Normal", "Low"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.font(name: "Kailasa Regular", size: 11)
        segmentedControl.tintColor = CustomConstants.textColor
        segmentedControl.frame.size = CGSize(width: 180, height: 32)
        segmentedControl.subviews.forEach { subview in
          subview.backgroundColor = CustomConstants.contentBackgroundColor
        }
        segmentedControl.backgroundColor = CustomConstants.contentBackgroundColor
        return segmentedControl
    }()
    
    private let addTaskButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame.size = CGSize(width: 60, height: 32)
        button.layer.cornerRadius = 8
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = CustomConstants.contentBackgroundColor
        button.titleLabel?.font = CustomConstants.setFont(fontSize: 11, isBold: false)
        button.setTitle("New Task", for: .normal)
        button.setTitle("New Task", for: .highlighted)
        button.layer.zPosition = 6
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tableView = createCollectionView()
        self.tableView = tableView
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = CustomConstants.backgroundColor
        setupConstraints()
        addTaskButton.addTarget(self, action: #selector(addTaskButtonTapped(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        guard let tableView = self.tableView else {return}
        addSubviews(tableView, segmentedControl, addTaskButton)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = CustomConstants.contentBackgroundColor
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalToConstant: 180),
            segmentedControl.heightAnchor.constraint(equalToConstant: 32),
            
            addTaskButton.widthAnchor.constraint(equalToConstant: 60),
            addTaskButton.heightAnchor.constraint(equalToConstant: 32),
            addTaskButton.centerYAnchor.constraint(equalTo: segmentedControl.centerYAnchor),
            addTaskButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 46),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -64),
        ])
    }
    
    private func createCollectionView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TaskListTableViewCell.self, forCellReuseIdentifier: TaskListTableViewCell.cellidentifier)
        return tableView
    }
    
    @objc
    private func addTaskButtonTapped(_ sender: UIButton) {
        delegate?.didAddNewTask()
    }
    
}

extension TaskListView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskListTableViewCell.cellidentifier, for: indexPath) as? TaskListTableViewCell else {
            fatalError("Unsupported cell")
        }
        return cell
    }
    
    
}
