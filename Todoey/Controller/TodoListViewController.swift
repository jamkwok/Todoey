//
//  ViewController.swift
//  Todoey
//
//  Created by James Kwok on 4/1/19.
//  Copyright © 2019 James Kwok. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard // Is a Singleton
    
    // Create new plist path
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        loadItemsAndRefreshTable()
        
    }

    //MARK: - TableView DataSource Methods
    // Triggered when tableview looks to fill cells, it gives the rows it needs back
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath as IndexPath) as UITableViewCell
        
        //configure your cell
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK:- TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItemsAndRefreshTable()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (action) in
            // What will happen once the user clicks add new item on our UIAlert.
            self.itemArray.append(Item(titleText: textField.text!))
            self.saveItemsAndRefreshTable()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
            // Do nothing to dismiss
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        //Add textfield to alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        // show alert
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Manipulation Methods
    func saveItemsAndRefreshTable() {
        //Persist Data inside a Plist file
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Failed to encode items or save to file \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItemsAndRefreshTable() {
        // Retrieve Persisted Data
        do {
            // get Encoded data from plist file
            if let data = try? Data(contentsOf: dataFilePath!) {
                let decoder = PropertyListDecoder()
                // Needs the data type to decode to using the .self after type signifies we are refering to the type
                itemArray = try decoder.decode([Item].self, from: data)
            }
        } catch {
            print("Failed to decode items or retrieve from file \(error)")
        }
        
        self.tableView.reloadData()
    }
}

