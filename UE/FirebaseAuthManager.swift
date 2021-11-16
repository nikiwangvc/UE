//
//  FirebaseAuthManager.swift
//  UE
//
//  Created by Niki Wang on 11/15/21.
//

import FirebaseAuth
import UIKit

//https://iosapptemplates.com/blog/swift-programming/firebase-swift-tutorial-login-registration-ios
class FirebaseAuthManager {
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
}
