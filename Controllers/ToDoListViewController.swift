//
//  ViewController.swift
//  ToDo
//
//  Created by Ilya Tyulenev on 20/02/2019.
//  Copyright © 2019 Ilya Tyulenev. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var toDoTextArray = [ToDoItem]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        loadData()
        
    }
    //===============================================================
    //MARK: - Set TableView methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        
        cell.textLabel?.text = toDoTextArray[indexPath.row].itemBody
        
        //Give item check/uncheck property from the database
        
        cell.accessoryType = toDoTextArray[indexPath.row].done ? .checkmark : .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoTextArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //toDoTextArray[indexPath.row].setValue("Updated itemBody", forKey: "itemBody") //update Database
//          context.delete(toDoTextArray[indexPath.row])
//          toDoTextArray.remove(at: indexPath.row)
        
        //Check/uncheck item in the list
        toDoTextArray[indexPath.row].done = !toDoTextArray[indexPath.row].done
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //=======================================================================
    //MARK: - Add new item
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        var userInput = UITextField()
        
        let alert = UIAlertController(title: "Add ToDO item", message: "", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Create a new ToDo item"
            userInput = textField
        }
        
        alert.addAction(UIAlertAction(title: "Add item", style: .default, handler: { (alert) in
            
            let newItem = ToDoItem(context: self.context)
            newItem.itemBody = userInput.text!
            self.toDoTextArray.append(newItem)
            
            
            self.saveData()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //=====================================================================
    //MARK: - Create functions to save and load data from CoreData
    
    func saveData() {
        
            do {
                try context.save()
            }
            catch {
                print("Error while saving data, \(error)")
            }
        
        tableView.reloadData()
        
    }
    
    //Load data
    func loadData(with request : NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()){
        
            do {
                toDoTextArray = try context.fetch(request)
            }
            catch {
                print("Error fetcing data from context, \(error)")
            }
        
        tableView.reloadData()

        }
}

//=======================================================================
//MARK: - Search bar Methods
extension ToDoListViewController : UISearchBarDelegate {
    
    //Searching methods
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count != 0 {
            
            //Get user search input
            let request : NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
            request.predicate = NSPredicate(format: "itemBody CONTAINS[cd] %@", searchBar.text!)
            
            //Set sort filter
            request.sortDescriptors = [NSSortDescriptor(key: "itemBody", ascending: true)]
            
            loadData(with: request)
        }
        
        else {
            //Without any filter
            loadData()
        }
    }
    
    //End search methods-----------------------------------------------------
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        loadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        
        if searchBar.text?.count != 0 {
        
            if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
            }
        }
        else {
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.resignFirstResponder()
        }
    }
    
}


