//
//  TaskViewController.swift
//  To-Do List
//
//  Created by Valera on 6/6/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import UIKit
import Firebase

class TaskViewController: UIViewController {

    var tasks: [Task] = []
    var ref: DatabaseReference!
    var user: User!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentUser = Auth.auth().currentUser else { return }
        user = User(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasks")
    }
    // Fetch data
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ref.removeAllObservers()
    }
    
    private func fetchData() {
        ref.observe(.value) { [weak self] (snapshot) in
            
            var _tasks: [Task] = []
            
            for item in snapshot.children {
                let task = Task(snapshot:  item as! DataSnapshot)
                _tasks.append(task)
            }
            self?.tasks = _tasks
            self?.tableView.reloadData()
        }
    }
    
    private func customizeCellLabel(cell: UITableViewCell) {
        
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        
        if cell.textLabel?.text != "" {
            cell.backgroundColor = UIColor(named: "B39564")
        }
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .justified
        cell.textLabel?.font = UIFont(name: "Papyrus", size: 20)
    }
    
    @IBAction func signOutButton(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        
        let task = tasks[indexPath.row]
        let taskTitle = task.title
        let isCompleted = task.completed
        toggleCompletion(cell, isCompleted: isCompleted)
        
        cell.textLabel?.text = taskTitle
        customizeCellLabel(cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        let task = tasks[indexPath.row]
        let isCompleted = !task.completed
        toggleCompletion(cell, isCompleted: isCompleted)
        task.ref?.updateChildValues(["completed": isCompleted])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let configurationDelete = UISwipeActionsConfiguration(actions: [UIContextualAction(style: .destructive, title: "Delete", handler: { [weak self] (action, view, completionHandler) in
            let task = self?.tasks[indexPath.row]
            task?.ref?.removeValue()
            
            completionHandler(true)
        })])
        return configurationDelete
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title: "Edit", handler: { [weak self] (action, view, completionHandler) in
            let task = self?.tasks[indexPath.row]
            guard let vc = self?.storyboard?.instantiateViewController(withIdentifier: "AddTaskViewController") as? AddTaskViewController else { return }
            vc.editableTaskTitle = (task?.title)!
            vc.cancelButton.isEnabled = false
            task?.ref?.removeValue()
            tableView.deselectRow(at: indexPath, animated: true)
            self?.navigationController?.pushViewController(vc, animated: true)
            completionHandler(true)
        })
        edit.backgroundColor = .orange
                                                                      
        let notification = UIContextualAction(style: .normal, title: "Notification", handler: { [weak self] (action, view, completionHandler) in
            guard let task = self?.tasks[indexPath.row].title else { return }
            
            guard let vcNotification = self?.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController else { return }
            vcNotification.taskNotification = task
            self?.navigationController?.pushViewController(vcNotification, animated: true)
            
            completionHandler(true)
        })
        notification.image = UIImage(systemName: "alarm.fill")
        notification.backgroundColor = UIColor(named: "A0FF78")
        
        let configuration = UISwipeActionsConfiguration(actions: [notification, edit])

        return configuration
    }
    
    func toggleCompletion(_ cell: UITableViewCell, isCompleted: Bool) {
        cell.accessoryType = isCompleted ? .checkmark : .none
        
    }
    
}

