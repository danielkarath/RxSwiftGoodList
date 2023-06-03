//
//  TaskListView.swift
//  RxSwiftGoodList
//
//  Created by Daniel Karath on 5/20/23.
//

import UIKit
import RxSwift
import RxCocoa

protocol TaskListViewDelegate: AnyObject {
    func didAddNewTask()
    func didSelect(priority: Int)
    func didUpdateTasks(_ tasks: [Task])
}

class TaskListView: UIView {
    
    public weak var delegate: TaskListViewDelegate?
    
    public var filteredTasks = [Task]()
    
    private var tableView: UITableView?
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["All", "High", "Normal", "Low"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.font(name: "Kailasa Regular", size: 11, normalColor: .black, selectedColor: .systemBlue)
        segmentedControl.tintColor = CustomConstants.basicFontColor
        segmentedControl.frame.size = CGSize(width: 180, height: 32)
        segmentedControl.subviews.forEach { subview in
            subview.backgroundColor = CustomConstants.contentBackgroundColor
        }
        segmentedControl.backgroundColor = CustomConstants.contentBackgroundColor
        segmentedControl.selectedSegmentTintColor = .clear.withAlphaComponent(0.0)
        segmentedControl.selectedSegmentIndex = 0
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
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
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
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let priority = sender.selectedSegmentIndex        
        
        delegate?.didSelect(priority: priority)
    }
    
    func reloadTableView() {
        tableView?.reloadData()
    }
    
}

extension TaskListView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskListTableViewCell.cellidentifier, for: indexPath) as? TaskListTableViewCell else {
            fatalError("Unsupported cell")
        }
        let task = filteredTasks[indexPath.row]
        cell.configure(with: task)
        return cell
    }
    
    
}
