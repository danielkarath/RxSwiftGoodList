//
//  ViewController.swift
//  RxSwiftGoodList
//
//  Created by Daniel Karath on 5/20/23.
//

import UIKit

class TaskListViewController: UIViewController {
    
    let taskListView = TaskListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = CustomConstants.backgroundColor
        setupConstraints()
        // Do any additional setup after loading the view.
    }

    private func setupConstraints() {
        view.addSubviews(taskListView)
        NSLayoutConstraint.activate([
            taskListView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            taskListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            taskListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            taskListView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
        ])
    }

}
