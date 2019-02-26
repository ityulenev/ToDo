//
//  CategoryViewController.swift
//  ToDo
//
//  Created by Ilya Tyulenev on 23/02/2019.
//  Copyright © 2019 Ilya Tyulenev. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var addCategoryBar: UITextField!
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
            
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
        self.categoryTableView.separatorStyle = .none
        
        loadData()
        
        //Register CustomCell.xib file
        categoryTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCategoryCell")
    }
    
    //======================================================
    //MARK: - Set categoryTableView methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoryTableView.dequeueReusableCell(withIdentifier: "customCategoryCell", for: indexPath) as! CategoryTableViewCell
        cell.categoryLabel?.text = categoryArray[indexPath.row].categoryName
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: indexPath)
        categoryTableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Identify Category in ToDoListViewController while performing segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems" {
            let destinationVC = segue.destination as! ToDoListViewController
            
            if let indexPath = categoryTableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categoryArray[indexPath.row]
            }
        }
    }
    
    //===================================================================
    //MARK: - Done Button pressed
    @IBAction func addingCategoryDone(_ sender: UITextField) {
        
        if addCategoryBar.text?.count != 0 {
            let newCategory = Category(context: context)
            newCategory.categoryName = addCategoryBar.text
            categoryArray.insert(newCategory, at: 0)
            addCategoryBar.text = ""
            
            saveData()
        }
        sender.resignFirstResponder()
    }
//====================================================================
//MARK: - Saving and loading Category data

    func saveData() {
        
        do {
            try context.save()
        }
        catch {
            print("Error while saving data, \(error)")
        }
        
        categoryTableView.reloadData()
        
    }
    
    //Load data
    func loadData(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        
        do {
            categoryArray = try context.fetch(request)
            categoryArray.reverse() //reverse DataBase order to show newest items
        }
        catch {
            print("Error fetcing data from context, \(error)")
        }
        
        categoryTableView.reloadData()
        
    }
    
}
