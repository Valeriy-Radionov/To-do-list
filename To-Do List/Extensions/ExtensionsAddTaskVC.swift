//
//  ExtensionsAddTaskVC.swift
//  To-Do List
//
//  Created by Valera on 6/23/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import UIKit

extension AddTaskViewController {
    
    // MARK: Keyboard Settings
    
    func keyboardSettings() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func updateTextView(notification: Notification) {
        
        guard let userInfo = notification.userInfo as? [String: Any],
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else {return}
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            taskTextView.contentInset = UIEdgeInsets.zero
        } else {
            taskTextView.contentInset = UIEdgeInsets(top: 0,
                                                     left: 0,
                                                     bottom: keyboardFrame.height,
                                                     right: 0)
            taskTextView.scrollIndicatorInsets = taskTextView.contentInset
        }
        taskTextView.scrollRangeToVisible(taskTextView.selectedRange)
    }
}
