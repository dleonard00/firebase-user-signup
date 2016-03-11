//
//  UserSignupAPI.swift
//  firebase-user-signup
//
//  Created by doug on 3/11/16.
//  Copyright © 2016 Weave. All rights reserved.
//

import Foundation
import Firebase


func createNewUser(email: String, username: String, password: String, success: (() -> Void)?, failure: ((NSError) -> Void)?){
    FirebaseRefManager.myRootRef.createUser(email, password: password,
        withValueCompletionBlock: { error, result in
            if error != nil {
                // There was an error creating the account
                failure?(error)
            } else {
                let uid = result["uid"] as? String
                print("Successfully created user account with uid: \(uid)")
                let newUser = [
                    "provider": "password",
                    "email": email,
                    "username": username,
                ]
                FirebaseRefManager.myRootRef.childByAppendingPath("/users")
                    .childByAppendingPath(uid).setValue(newUser)
                success?()
            }
    })
}
