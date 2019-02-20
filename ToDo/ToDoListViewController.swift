//
//  ViewController.swift
//  ToDo
//
//  Created by Ilya Tyulenev on 20/02/2019.
//  Copyright © 2019 Ilya Tyulenev. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var toDoTextArray = ["Clean bath", "Meet Mike", "Call Bob"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
    }
    
    
    //MARK: Set TableView methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        
        cell.textLabel?.text = toDoTextArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoTextArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
           tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
}

