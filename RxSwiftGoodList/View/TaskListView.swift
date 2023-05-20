//
//  TaskListView.swift
//  RxSwiftGoodList
//
//  Created by Daniel Karath on 5/20/23.
//

import UIKit

class TaskListView: UIView {
    
    private var tableView: UITableView?
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["one", "two"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.tintColor = CustomConstants.textColor
        segmentedControl.frame.size = CGSize(width: 128, height: 40)
        segmentedControl.subviews.forEach { subview in
          subview.backgroundColor = CustomConstants.contentBackgroundColor
        }
        segmentedControl.backgroundColor = CustomConstants.contentBackgroundColor
        return segmentedControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tableView = createCollectionView()
        self.tableView = tableView
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = CustomConstants.backgroundColor
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        guard let tableView = self.tableView else {return}
        addSubviews(tableView, segmentedControl)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = CustomConstants.contentBackgroundColor
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: topAnchor, constant: 64),
            segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalToConstant: 128),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40),
            
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
