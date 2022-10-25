//
//  Task.swift
//  ToDoList
//
//  Created by Christophorus Davin on 25/10/22.
//

import Foundation

enum Priority: Int{
    case High
    case Medium
    case Low
}


struct Task {
    let priority: Priority
    let title: String
}
