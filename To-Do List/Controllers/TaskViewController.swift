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
    
    
    var array = ["1ldkngkejkefvkefnvenenbnerbnenbveronborenboirenioernboiernoibneroibnorienoignerognerognoerngferognerognreognerognerognoerignoengoie","2","3","4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        customizeCellLabel(cell: cell)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    
    
}
