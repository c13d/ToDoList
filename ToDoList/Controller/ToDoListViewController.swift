//
//  ToDoListController.swift
//  ToDoList
//
//  Created by Christophorus Davin on 25/10/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ToDoListViewController: UIViewController {
    
    let viewModel = ToDoListViewModel.toDoListViewModel
    
    let disposeBag = DisposeBag()

    var tableView = UITableView()
    var segementedControl = UISegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let priority = Priority(rawValue: segementedControl.selectedSegmentIndex - 1)
        viewModel.filterTask(by: priority)
        
    }
}


extension ToDoListViewController {
    private func setup() {
        setupNavBar()
        
        setupSegementationControl()
        setupTableView()
        
        bindingDataToTableView()
        
    }
    
    
    private func setupSegementationControl() {
        let items = ["All", "High", "Medium", "Low"]
        
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
        
        // Rx
        segementedControl.rx.selectedSegmentIndex.subscribe(onNext: {
            [weak self] index in
            let priority = Priority(rawValue: index - 1)
            
            self!.viewModel.filterTask(by: priority)
            print("filtered: \(self!.viewModel.filteredTask)")
            
        }).disposed(by: disposeBag)
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "To Do List"
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToAddTask))
        self.navigationItem.rightBarButtonItem  = button
    }
    
    @objc func goToAddTask() {
        let addTask = AddTaskViewController()
        self.navigationController?.pushViewController(addTask, animated: true)
    }
    
    func bindingDataToTableView() {
        // Rx
        viewModel.tasks.asObservable()
            .bind(to: tableView.rx
                .items(cellIdentifier: ToDoListTableViewCell.reuseID, cellType: ToDoListTableViewCell.self))
        {  [weak self] index, element, cell  in
    
            cell.configure(with: element)
            
            cell.finishButton.rx.tap
                .subscribe(onNext: { [weak self] in
                    
                    self!.viewModel.removeTask(deletedTask: cell.task)
                    
                    let priority = Priority(rawValue: self!.segementedControl.selectedSegmentIndex - 1)
                    self!.viewModel.filterTask(by: priority)
                    
                }).disposed(by: cell.disposeBag)
                
            
        }.disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        tableView.register(ToDoListTableViewCell.self, forCellReuseIdentifier: ToDoListTableViewCell.reuseID)
        tableView.rowHeight = ToDoListTableViewCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: segementedControl.topAnchor, multiplier: 6),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
