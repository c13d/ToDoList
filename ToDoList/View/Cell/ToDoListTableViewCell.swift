//
//  ToDoListViewCell.swift
//  ToDoList
//
//  Created by Christophorus Davin on 25/10/22.
//

import Foundation
import UIKit
import RxSwift

class ToDoListTableViewCell: UITableViewCell {
    let disposeBag = DisposeBag()
    
    let typeLabel = UILabel()
    let underlineView = UIView()
    let nameLabel = UILabel()
    let finishButton = UIButton(type: .system)
    
    var task = Task(priority: .Low, title: "")
    
    
    static let reuseID = "ToDoListTableViewCell"
    static let rowHeight: CGFloat = 100
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ToDoListTableViewCell {
    
    private func setup() {
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.text = "type"
        
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = .systemBlue
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.text = "name"
        
        finishButton.translatesAutoresizingMaskIntoConstraints = false
        finishButton.configuration = .filled()
        finishButton.configuration?.imagePadding = 8 // for indicator spacing
        finishButton.setTitle("Finish", for: [])
        
        
        
        contentView.addSubview(typeLabel)
        contentView.addSubview(underlineView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(finishButton)
        
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            underlineView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            underlineView.widthAnchor.constraint(equalToConstant: 60),
            underlineView.heightAnchor.constraint(equalToConstant: 4),
            
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            finishButton.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 0),
            finishButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
            trailingAnchor.constraint(equalToSystemSpacingAfter: finishButton.trailingAnchor, multiplier: 4)
        ])
        
        
    }
}

extension ToDoListTableViewCell {
    func configure(with vm: Task) {
        self.task = vm
        
        nameLabel.text = vm.title
        
        switch vm.priority {
        case .High:
            underlineView.backgroundColor = .systemRed
            typeLabel.text = "High"
            break
        case .Medium:
            underlineView.backgroundColor = .systemBlue
            typeLabel.text = "Medium"
            break
        case .Low:
            underlineView.backgroundColor = .systemGreen
            typeLabel.text = "Low"
            break
        }
    }
}
