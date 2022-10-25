//
//  ToDoListViewModel.swift
//  ToDoList
//
//  Created by Christophorus Davin on 25/10/22.
//

import Foundation
import RxSwift
import RxCocoa

class ToDoListViewModel {
    
    let disposeBag = DisposeBag()
    
    static let toDoListViewModel = ToDoListViewModel()
    
    var tasks = BehaviorRelay<[Task]>(value: [])
    var filteredTask = [Task]()
    var allTasks = [Task]()
    
    private init(){
        let dummy = [
            Task(priority: .High, title: "Task1"),
            Task(priority: .Medium, title: "Task2"),
            Task(priority: .Low, title: "Task3"),
            
            Task(priority: .Medium, title: "Task4"),
        ]
        
        allTasks = dummy
        tasks.accept(allTasks)
    }
    
    
    func addNewTask(task: Task){
        allTasks.append(task)
    }
    
    func removeTask(deletedTask: Task){
        //print("remove \(task)")
        var idx = 0
        for task in self.allTasks {
            if task.priority == deletedTask.priority && task.title == deletedTask.title {
                allTasks.remove(at: idx)
                return
            }
            idx += 1
        }
    }
    
    func filterTask(by priority: Priority?){
        tasks.accept(allTasks)
        if priority == nil {

        }else{
            self.tasks.map { tasks in
                return tasks.filter { $0.priority == priority!}
            }.subscribe(onNext: { [weak self] tasks in
                self?.filteredTask = tasks
            }).disposed(by: disposeBag)
            tasks.accept(filteredTask)
        }
    }
    
}
