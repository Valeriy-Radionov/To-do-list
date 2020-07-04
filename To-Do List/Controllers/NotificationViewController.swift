//
//  NotificationViewController.swift
//  To-Do List
//
//  Created by Valera on 7/2/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    
    let notifications = Notifications()
    var taskNotification = ""
    
    @IBOutlet var dataPicker: UIDatePicker!
    @IBOutlet var dateOfNoticeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeData(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .short
        let dateValue = dateFormatter.string(from: sender.date)
        dateOfNoticeLabel.text = "Date of notice: \(dateValue)"
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addNotification(_ sender: UIBarButtonItem) {
        self.notifications.sheduleNotification(notificationType: taskNotification, date: dataPicker.date)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
