//
//  Task.swift
//  To-Do List
//
//  Created by Valera on 6/11/20.
//  Copyright © 2020 Valera. All rights reserved.
//

import Foundation
import Firebase

struct Task {
    
    let title: String
    let userId: String
    let ref: DatabaseReference?
    var completed = false
    
    init(title: String, userId: String) {
        self.title = title
        self.userId = userId
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        title = snapshotValue["title"] as! String
        userId = snapshotValue["userId"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
    
    func convertToDictionary() -> Any {
        return ["title": title,  "userId": userId, "completed": completed]
    }
    
}
