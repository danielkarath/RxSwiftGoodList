//
//  ViewController.swift
//  RxSwiftGoodList
//
//  Created by Daniel Karath on 5/20/23.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController {
    
    let taskListView = TaskListView()
    private let disposebag = DisposeBag()
    public var tasks = BehaviorRelay(value: [Task]())
    private var filteredPriority: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = CustomConstants.backgroundColor
        taskListView.delegate = self
        setupConstraints()
        didUpdateTasks(tasks.value)
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

extension TaskListViewController: TaskListViewDelegate {
    func didSelect(priority: Int) {
        filteredPriority = priority
    }
    
    func didUpdateTasks(_ tasks: [Task]) {
            taskListView.filteredTasks = tasks
        }
    
    func didAddNewTask() {
        let addNewTaskVC = AddTaskViewController()
        addNewTaskVC.taskSubjectObservable
            .subscribe(onNext: { task in
                let priority = Priority(rawValue: task.priority.rawValue)
                var currentTasks = self.tasks.value
                currentTasks.append(task)
                self.tasks.accept(currentTasks)
                print("Did save task: \(task.title)\nwith priority: \(priority)")

                self.taskListView.delegate?.didUpdateTasks(currentTasks) // Call the delegate method here
            }).disposed(by: disposebag)
        self.present(addNewTaskVC, animated: true, completion: nil)
    }

}
