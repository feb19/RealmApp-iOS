//
//  ViewController.swift
//  TodoRealmApp-iOS
//
//  Created by Nobuhiro Takahashi on 2018/08/05.
//  Copyright © 2018年 Nobuhiro Takahashi. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UITableViewController {

    private var realm: Realm!
    private var todoList: Results<TodoItem>!
    private var token: NotificationToken!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        realm = try! Realm()
        todoList = realm.objects(TodoItem.self)
        token = todoList.observe { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    deinit {
        token.invalidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addButtonWasTapped(_ sender: UIBarButtonItem) {
        let dlg = UIAlertController(title: "Create", message: "", preferredStyle: .alert)
        dlg.addTextField(configurationHandler: nil)
        dlg.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let t = dlg.textFields![0].text,
                !t.isEmpty {
                self.addTodoItem(title: t)
            }
        }))
        present(dlg, animated: true)
    }
    
    func addTodoItem(title: String) {
        try! realm.write {
            realm.add(TodoItem(value: ["title": title]))
        }
    }
    func removeTodoItem(at index: Int) {
        try! realm.write {
            realm.delete(todoList[index])
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell")
        cell?.textLabel?.text = todoList[indexPath.row].title
        return cell!
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        removeTodoItem(at: indexPath.row)
    }
    
}

