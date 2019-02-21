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
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
       if let items = defaults.array(forKey: "defaultsArray") as? [String] {
            toDoTextArray = items
        }
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
        
        //Check/uncheck item in the list
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
           tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Add new item
    
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        var userInput = UITextField()
        let alert = UIAlertController(title: "Add ToDO item", message: "", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Create a new ToDo item"
            userInput = textField
        }
        
        alert.addAction(UIAlertAction(title: "Add item", style: .default, handler: { (alert) in
            self.toDoTextArray.append(userInput.text!)
            self.defaults.set(self.toDoTextArray, forKey: "defaultsArray")
            self.tableView.reloadData()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

