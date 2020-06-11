//
//  AddTaskViewController.swift
//  To-Do List
//
//  Created by Valera on 6/9/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import UIKit
import Firebase
class AddTaskViewController: UIViewController {

    var user: User!
    var ref: DatabaseReference!
    var tasks: [Task] = []
    
    @IBOutlet var taskTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentUser = Auth.auth().currentUser else { return }
        user = User(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasks")
    }
    
    private func warningEmptyTask() {
        
        guard let taskTextView = taskTextView, taskTextView.text != "" else {
            
            let alertController = UIAlertController(title: "Task", message: "cannot save empty task", preferredStyle: .alert)
            let action = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
            return
        }
    }

    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func saveTaskButton(_ sender: UIBarButtonItem) {
        
        warningEmptyTask()
        let alertController = UIAlertController(title: "Task", message: "Add task?", preferredStyle: .alert)
        let add = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            let task = Task(title: (self?.taskTextView.text)!, userId: (self?.user.uid)!)
            let taskRef = self?.ref.child(task.title.lowercased())
            taskRef?.setValue(task.convertToDictionary())
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(add)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
        
        // task
        // где будет храниться задача taskRef
        // по адресу taskRef поместить task
        
    }
    
}
