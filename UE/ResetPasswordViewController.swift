//
//  ResetPasswordViewController.swift
//  UE
//
//  Created by Niki Wang on 11/29/21.
//

import UIKit
import Firebase

let ERROR_EMPTY_EMAIL_RESET = "Please enter your email for password reset."
class ResetPasswordViewController:
    UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var ResetPassword: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetPasswordTapped(_ sender: Any) {
        
        
    }



}
