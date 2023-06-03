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
    
    private func filter(by priorityNum: Int) {
        var priority: Priority?
        switch priorityNum {
        case 0:
            priority = nil
        case 1:
            priority = .high
        case 2:
            priority = .normal
        case 3:
            priority = .low
        default:
            priority = nil
        }
        
        if priority == nil {
            taskListView.filteredTasks = self.tasks.value
        } else {
            self.tasks.map { tasks in
                return tasks.filter { $0.priority == priority}
            }.subscribe(onNext: { [weak self] tasks in
                self?.taskListView.filteredTasks = tasks
                print("filtered tasks: \(tasks)")
            }).disposed(by: disposebag)
        }
        
    }

}

extension TaskListViewController: TaskListViewDelegate {
    func didSelect(priority: Int) {
        print("Selected priority value is: \(priority)")
        filter(by: priority)
        didUpdateTasks(taskListView.filteredTasks)
    }
    
    func didUpdateTasks(_ tasks: [Task]) {
        taskListView.filteredTasks = tasks
        taskListView.reloadTableView()
    }
    
    func didAddNewTask() {
        let addNewTaskVC = AddTaskViewController()
        addNewTaskVC.taskSubjectObservable
            .subscribe(onNext: { task in
                let priority = Priority(rawValue: task.priority.rawValue)
                var currentTasks = self.tasks.value
                currentTasks.append(task)
                self.tasks.accept(currentTasks)
                
                self.taskListView.delegate?.didUpdateTasks(currentTasks) // Call the delegate method here
            }).disposed(by: disposebag)
        self.present(addNewTaskVC, animated: true, completion: nil)
    }

}
