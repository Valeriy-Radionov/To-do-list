//
//  ExtensionInputViewController.swift
//  To-Do List
//
//  Created by Valera on 6/23/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import UIKit



extension InputViewController {
    
    // MARK: Keyboard Settings
    
    func keyboardSettings() {
        
        NotificationCenter.default.addObserver(self, selector:  #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:  #selector(keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        errorLabel.alpha = 0
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        
        guard let userInfo = notification.userInfo else { return }
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width,
                                                          height: self.view.bounds.size.height + kbFrameSize.height)
        
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0,
                                                                          left: 0,
                                                                          bottom:  kbFrameSize.height,
                                                                          right: 0)
    }
    
    @objc func keyboardDidHide() {
        
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    
    
}
