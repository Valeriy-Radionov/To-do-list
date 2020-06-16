//
//  User.swift
//  To-Do List
//
//  Created by Valera on 6/11/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import Foundation
import Firebase

struct User {
    
    let uid: String
    let email: String
    
    init(user: Firebase.User) {
        self.uid = user.uid
        self.email = user.email!
    }
    
}
