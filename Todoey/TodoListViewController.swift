//
//  ViewController.swift
//  Todoey
//
//  Created by James Kwok on 4/1/19.
//  Copyright © 2019 James Kwok. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgan"]

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
        print(tableView.cellForRow(at: indexPath)?.accessoryType)
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
        print("selected", itemArray[indexPath.row])
    }
    
    
}

