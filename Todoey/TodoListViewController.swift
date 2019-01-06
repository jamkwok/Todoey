//
//  ViewController.swift
//  Todoey
//
//  Created by James Kwok on 4/1/19.
//  Copyright © 2019 James Kwok. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - TableView DataSource Methods
    // Triggered when tableview looks to fill cells, it gives the rows it needs back
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath as IndexPath) as UITableViewCell
        
        //configure your cell
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK:- TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (action) in
            // What will happen once the user clicks add new item on our UIAlert.
            self.itemArray.append(textField.text!)
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

