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
    
    
    @IBOutlet var taskTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentUser = Auth.auth().currentUser else { return }
        user = User(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasks")
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveTaskButton(_ sender: UIBarButtonItem) {
        
        guard let taskTextView = taskTextView, taskTextView.text != "" else { return }
       
        let task = Task(title: self.taskTextView.text, userId: self.user.uid)
        let taskRef = self.ref.child(task.title.lowercased())
        taskRef.setValue(task.convertToDictionary())

        self.navigationController?.popViewController(animated: true)
        }
        
    }
    

