//
//  ViewController.swift
//  ToDo
//
//  Created by Ilya Tyulenev on 20/02/2019.
//  Copyright © 2019 Ilya Tyulenev. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var toDoTextArray = [ToDoItem]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
       if let items = defaults.object(forKey: "defaultsArray") {
        toDoTextArray = items as! [ToDoItem]
        }
    }
    
    
    //MARK: Set TableView methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        
        cell.textLabel?.text = toDoTextArray[indexPath.row].itemBody
        
        //Give item check/uncheck property from the database
        
        cell.accessoryType = toDoTextArray[indexPath.row].done ? .none : .checkmark

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoTextArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Check/uncheck item in the list
        toDoTextArray[indexPath.row].done = !toDoTextArray[indexPath.row].done
        
        
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
            
            let newItem = ToDoItem()
            newItem.itemBody = userInput.text!
            self.toDoTextArray.append(newItem)
            
            self.defaults.set(self.toDoTextArray, forKey: "defaultsArray")
            self.tableView.reloadData()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

