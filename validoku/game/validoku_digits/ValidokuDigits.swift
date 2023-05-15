//
//  ValidokuDigits.swift
//  Validoku
//
//  Created by Xiaomi on 13.05.2023.
//

import UIKit

class ValidokuDigits : UIView {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var dataSource = [ValidokuDigit]()
    
    public func setupTableView() {
        setWidth(400)
        setHeight(40)
        
        tableView.register(ValidokuDigitCell.self,
                           forCellReuseIdentifier:
                            ValidokuDigitCell.reuseIdentifier)
        
        for i in 1...9 {
            let cell = ValidokuDigitCell()
            cell.addDigit(digit: i)
            cell.setupView()
            tableView.addSubview(cell)
            cell.pinLeft(to: self, Double(10 * (i - 1)))
        }
        
        addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        addSubview(tableView)
        tableView.pinCenter(to: self)
    }
    
    private func handleDelete(indexPath: IndexPath) {
        dataSource.remove(at: indexPath.row)
        tableView.reloadData()
    }
}

extension ValidokuDigits : UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt
                   indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: .none
        ) { [weak self] (action, view, completion) in
            self?.handleDelete(indexPath: indexPath)
            completion(true)
        }
        
        deleteAction.image = UIImage(
            systemName: "trash.fill",
            withConfiguration: UIImage.SymbolConfiguration(weight: .bold)
        )?.withTintColor(.white)
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}


extension ValidokuDigits : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return dataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
    UITableViewCell {
        switch indexPath.section {
        case 0:
            if let addNewCell = tableView.dequeueReusableCell(withIdentifier:
                                                                ValidokuDigitCell.reuseIdentifier, for: indexPath) as? ValidokuDigitCell {
                return addNewCell
            }
        default:
            //let note = dataSource[indexPath.row]
            if let noteCell = tableView.dequeueReusableCell(withIdentifier:
                                                                ValidokuDigitCell.reuseIdentifier, for: indexPath) as? ValidokuDigitCell {
                return noteCell
            }
        }
        return UITableViewCell()
    }
}

