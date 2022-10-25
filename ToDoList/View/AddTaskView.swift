//
//  AddTaskView.swift
//  ToDoList
//
//  Created by Christophorus Davin on 25/10/22.
//

import Foundation
import UIKit

class TaskView: UIView {
    
    let stackView = UIStackView()
    let newTaskTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init has not been implemented")
    }
    

}

extension TaskView
{
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        newTaskTextField.translatesAutoresizingMaskIntoConstraints = false
        newTaskTextField.placeholder = "New Task"
        newTaskTextField.delegate = self
    
        
        layer.cornerRadius = 5
        clipsToBounds = true
    }
    
    func layout() {
        
        stackView.addArrangedSubview(newTaskTextField)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
        ])

    }
}

// Delegate
extension TaskView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newTaskTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
}
