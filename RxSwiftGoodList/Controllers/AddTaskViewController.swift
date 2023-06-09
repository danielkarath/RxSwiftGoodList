//
//  AddTaskViewController.swift
//  RxSwiftGoodList
//
//  Created by Daniel Karath on 5/20/23.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {
        
    private let addTaskView = AddTaskView()
    
    private let taskSubject = PublishSubject<Task>()
    public var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = CustomConstants.backgroundColor
        addTaskView.delegate = self
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubviews(addTaskView)
        NSLayoutConstraint.activate([
            addTaskView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            addTaskView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            addTaskView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            addTaskView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
        ])
    }
    
}

extension AddTaskViewController: AddTaskViewDelegate {
    func didSave(_ task: Task) {
        taskSubject.onNext(task)
        self.dismiss(animated: true)
    }
    
    func cancelTask() {
        print("Did tap cancel task")
        self.dismiss(animated: true)
    }
}
