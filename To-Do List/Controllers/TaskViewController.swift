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
           cell.backgroundColor = UIColor(named: "B39564")
           cell.textLabel?.numberOfLines = 0
           cell.textLabel?.textAlignment = .justified
           
    }
    
    @IBAction func addTaskButton(_ sender: UIBarButtonItem) {
        
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        customizeCellLabel(cell: cell)
        let taskTitle = tasks[indexPath.row].title
        cell.textLabel?.text = taskTitle
        return cell
    }
    
    
}
