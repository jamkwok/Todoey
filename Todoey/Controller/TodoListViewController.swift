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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieve Persisted Data
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
        tableView.reloadData()
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
            //Persist Data inside a PList file

            self.tableView.reloadData()
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
}

