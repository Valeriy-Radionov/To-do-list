//
//  AddTaskViewController.swift
//  To-Do List
//
//  Created by Valera on 6/9/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet var taskTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func warningEmptyTask() {
        
        guard let taskTextView = taskTextView, taskTextView.text != "" else {
            
            let alertController = UIAlertController(title: "Task", message: "cannot save empty task", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
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
        // task
        // где будет храниться задача taskRef
        // по адресу taskRef поместить task
        
    }
    
}
