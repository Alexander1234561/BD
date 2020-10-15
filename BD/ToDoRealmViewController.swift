//
//  ToDoRealmViewController.swift
//  BD
//
//  Created by Александр on 14.10.2020.
//  Copyright © 2020 Александр. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoRealmViewController: UIViewController {
    @IBOutlet weak var toDoTableView: UITableView!
    @IBOutlet weak var doElTextField: UITextField!
    
    private let realm = try! Realm()
    
    override func viewDidLoad() {
        toDoTableView.delegate = self
    }
    @IBAction func addDo(_ sender: UIButton){
        if doElTextField.text != ""{
            let todo = ToDo()
            todo.nameDo = doElTextField.text!
            todo.todo = false
            try! realm.write{realm.add(todo)}
            self.toDoTableView.reloadData()
        }
    }
}

extension ToDoRealmViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(ToDo.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoRealm") as! ToDoRealmTableViewCell
        cell.todoLabel.text = realm.objects(ToDo.self)[indexPath.row].nameDo
        if (realm.objects(ToDo.self)[indexPath.row].todo){
            cell.backgroundColor = UIColor.green
        } else{ cell.backgroundColor = UIColor.white }
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "delete") { (_, indexPath) in
            let td = self.realm.objects(ToDo.self)[indexPath.row]
            try! self.realm.write{self.realm.delete(td)}
            self.toDoTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let change = UITableViewRowAction(style: .normal, title: "Do") { (c, indexPath) in
            let td = self.realm.objects(ToDo.self)[indexPath.row]
            try! self.realm.write{ td.todo = true }
            self.toDoTableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.green
        }
        return [delete, change]
    }
}
