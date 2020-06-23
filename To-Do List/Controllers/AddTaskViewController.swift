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
    
    var ref: DatabaseReference!
    var user: User!
    var editableTaskTitle = ""
    
    @IBOutlet var taskTextView: UITextView!
    @IBOutlet var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTextView.text = editableTaskTitle
        keyboardSettings()
        
        guard let currentUser = Auth.auth().currentUser else { return }
        user = User(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasks")
    }
    
    private func warningAddTaskTextViewIsEmpty() {
        let alertWarning = UIAlertController(title: "Task", message: "Task cannot be empty", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
        
        alertWarning.addAction(alertAction)
        present(alertWarning, animated: true, completion: nil)
    }
    
    // MARK: Actions
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveTaskButton(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Task", message: "add Task?", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            
            guard let taskTextView = self?.taskTextView, taskTextView.text != "" else {
                self?.warningAddTaskTextViewIsEmpty()
                return
            }
            
            let task = Task(title: (self?.taskTextView.text)!, userId: (self?.user.uid)!)
            let taskRef = self?.ref.childByAutoId()
            taskRef?.setValue(task.convertToDictionary())
            
            self?.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(addAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
}


