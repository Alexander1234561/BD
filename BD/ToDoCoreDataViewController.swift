//
//  ToDoCoreDataViewController.swift
//  BD
//
//  Created by Александр on 14.10.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit
import CoreData

class ToDoCoreDataViewController: UIViewController {
    
    @IBOutlet weak var toDoTableView: UITableView!
    var todoList: Array<NSManagedObject> = []
    @IBOutlet weak var doElTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ToDo2")
        
        do {
            todoList = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    @IBAction func addDo(_ sender: UIButton) {
        if doElTextField.text != "" {
            saveName(doingName: doElTextField.text!, todo: false)
            self.toDoTableView.reloadData()
        }
    }
    
    //Сохранение данных в CoreData
    
    func saveName(doingName: String, todo: Bool) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ToDo2",in: managedContext)!
        let doing = NSManagedObject(entity: entity, insertInto: managedContext)
        doing.setValue(doingName, forKeyPath: "doingName")
        doing.setValue(todo, forKey: "todo")
        do {
            try managedContext.save()
            todoList.append(doing)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

extension ToDoCoreDataViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoreDataToDo") as! ToDoCoreDataTableViewCell
        cell.todoLabel.text = (todoList[indexPath.row].value(forKey: "doingName") as! String)
        if (todoList[indexPath.row].value(forKey: "todo") as! Bool){
            cell.backgroundColor = UIColor.green
        } else{ cell.backgroundColor = UIColor.white }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "delete") { (_, indexPath) in
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let managedContext = appDelegate?.persistentContainer.viewContext
            managedContext?.delete(self.todoList[indexPath.row])
            self.todoList.remove(at: indexPath.row)
            do {
                try managedContext?.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            self.toDoTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let change = UITableViewRowAction(style: .normal, title: "Do") { (_, indexPath) in
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let managedContext = appDelegate?.persistentContainer.viewContext
            
            self.todoList[indexPath.row].setValue(true, forKey: "todo")
            
            do {
                try managedContext?.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            
            self.toDoTableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.green
        }
        return [delete, change]
    }
}
