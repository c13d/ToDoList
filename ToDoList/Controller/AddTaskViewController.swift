
//
//  AddTaskController.swift
//  ToDoList
//
//  Created by Christophorus Davin on 25/10/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class AddTaskViewController: UIViewController {

    let taskView = TaskView()
    let errorMessageLabel = UILabel()
    
    var segementedControl = UISegmentedControl()
    
    var newTaskTextField: String? {
        return taskView.newTaskTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupNavBar()
        
        setupSegementationControl()
        style()
        layout()
    }
    
    private func setupSegementationControl() {
        let items = ["High", "Medium", "Low"]
        
        segementedControl = {
            let control = UISegmentedControl(items: items)
            control.selectedSegmentIndex = 0
        
            return control
        }()
        
        
        segementedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segementedControl)
        
        
        
        NSLayoutConstraint.activate([
            segementedControl.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            segementedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        

    }
    
    private func setupNavBar() {
        //navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Add New Task"
        let button = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNewTask))
        self.navigationItem.rightBarButtonItem  = button
    }
    
}

extension AddTaskViewController {
    
    private func style() {
        taskView.translatesAutoresizingMaskIntoConstraints = false
        
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.text = ""
        errorMessageLabel.isHidden = true
    }
    
    private func layout() {

        view.addSubview(taskView)
        view.addSubview(errorMessageLabel)
        
        
        NSLayoutConstraint.activate([
            taskView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            taskView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: taskView.trailingAnchor, multiplier: 1),
            
        ])
        

        
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: taskView.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: taskView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: taskView.trailingAnchor),
        ])
        
        
    }
}

// MARK: Actions
extension AddTaskViewController {
    @objc func saveNewTask(sender: UIButton) {
        errorMessageLabel.isHidden = true
        newTask()
    }
    
    private func newTask() {
        guard let newTaskTextField = newTaskTextField else{
            assertionFailure("username and password never be nil")
            
            return
        }
        
        if newTaskTextField == "" {
            configureView(withMessage: "New task must be filled")
        }else{
            // save
            guard let priority = Priority(rawValue: segementedControl.selectedSegmentIndex) else{
                return
            }
            
            let newTask = Task(priority: priority, title: newTaskTextField)
     
            ToDoListViewModel.toDoListViewModel.addNewTask(task: newTask)
            
            
            print("Save")
            navigationController?.popViewController(animated: true)
            self.dismiss(animated: true,completion: nil)
            
        }
    
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
}

