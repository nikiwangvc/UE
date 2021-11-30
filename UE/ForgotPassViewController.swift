//
//  ForgotPassViewController.swift
//  UE
//
//  Created by Niki Wang on 11/29/21.
//

import UIKit
import Firebase

class ForgotPassViewController: UIViewController {
    

    @IBOutlet var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: email.text!){(error)in
            if let error = error {
                let dialogMessage = UIAlertController(title: "Attention", message: error.localizedDescription, preferredStyle: .alert)
                
                // Create OK button with action handler
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    print("Ok button tapped")
                 })
                
                //Add OK button to a dialog message
                dialogMessage.addAction(ok)
                // Present Alert to
                self.present(dialogMessage, animated: true, completion: nil)
                return
                
            }
            let alert = UIAlertController(title: "Password Reset Link Sent", message: "Please check you email and follow the instruction", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
}
