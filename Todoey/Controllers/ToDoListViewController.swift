//
//  ViewController.swift
//  Todoey
//
//  Created by Admin on 8/6/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
 var itemArray = [Item]()
   
  let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        let newItem2 = Item()
        newItem2.title = "Buy Eggs"
        itemArray.append(newItem2)
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        let newItem4 = Item()
        newItem4.title = "Find Mike"
        itemArray.append(newItem4)
        
        
                if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
            itemArray = items
        }
    }

//MARK  - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       let item = itemArray[indexPath.row]
        
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
          return cell
        
    }
    //MARK -
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    //MARK - Add New Items
    
    @IBAction func UIBarButtonItem(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add item button on our UIAlert
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
               }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create New ietm"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
}
