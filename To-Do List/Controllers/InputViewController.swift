//
//  ViewController.swift
//  To-Do List
//
//  Created by Valera on 6/6/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import UIKit
import Firebase

class InputViewController: UIViewController {

    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.keyboardSettings()
        self.authorizationСheck()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    private func errorWarningLabel(withText text: String) {
        
        errorLabel.text = text
        
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: { [weak self] in
            self?.errorLabel.alpha = 1
        }) { [weak self] complete in
            self?.errorLabel.alpha = 0
        }
    }
    
    private func authorizationСheck() {
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
        if user != nil {
            guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "NavigationController") as? UINavigationController else{ return }
            self.present(controller, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: Keyboard Settings
    
    func keyboardSettings() {
        
        NotificationCenter.default.addObserver(self, selector:  #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:  #selector(keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        errorLabel.alpha = 0
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        
        guard let userInfo = notification.userInfo else { return }
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + kbFrameSize.height)
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom:  kbFrameSize.height, right: 0)
    }
    
    @objc func keyboardDidHide() {
        
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    
    // MARK: Actions
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        guard let email =  emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            errorWarningLabel(withText: "The entered information is incorrect")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            if error != nil {
                self?.errorWarningLabel(withText: "error occurred")
                return
            }
            
        if user != nil {
            guard let controller = self?.storyboard?.instantiateViewController(withIdentifier: "TaskNavigationController") as? UINavigationController else{ return }
            self?.present(controller, animated: true, completion: nil)
            return
            }
        
        self?.errorWarningLabel(withText: "No uch user")
        }
    }
        
    @IBAction func registrButton(_ sender: UIButton) {
        
        guard let email =  emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            errorWarningLabel(withText: "The entered information is incorrect")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error) in
            
            if error == nil {
                if user != nil {
                    
                } else {
                    print("user is not created")
                }
            } else {
                print(error!.localizedDescription)
            }
        })
    }
}

// MARK: UITextFieldDelegate

extension InputViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

    

