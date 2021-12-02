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
    
    @IBOutlet var send: UIButton!
    @IBOutlet var login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
 
    @IBAction func sendButtonTapped(_ sender: Any) {
        if (email.text?.isEmpty == false) {

                Auth.auth().sendPasswordReset(withEmail: email.text!){(error)in
                    if error == nil{
                        let dialogMessage = UIAlertController(title: "Password reset link sent!", message: "Please check your email inbox and proceed following the instructions.", preferredStyle: .alert)
                    
                    // Create OK button with action handler
                        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        print("Ok button tapped")
                     })
                    
                    //Add OK button to a dialog message
                        dialogMessage.addAction(ok)
                    // Present Alert to
                        self.present(dialogMessage, animated: true, completion: nil)
                        print("Sent")
                        return
                    }else{
                        let dialogMessage = UIAlertController(title: "User does not exist", message: "Please check your email or proceed to sign up :)", preferredStyle: .alert)
                    
                    // Create OK button with action handler
                        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        print("Ok button tapped")
                     })
                    
                    //Add OK button to a dialog message
                        dialogMessage.addAction(ok)
                    // Present Alert to
                        self.present(dialogMessage, animated: true, completion: nil)
                        print("Failed - \(String(describing:error?.localizedDescription))")
                        return
                    }
                }

            }
        else {
            let dialogMessage = UIAlertController(title: "Attention", message: "Please enter your email", preferredStyle: .alert)
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                print("Ok button tapped")
            })
    
            //Add OK button to a dialog message
            dialogMessage.addAction(ok)
            // Present Alert to
            self.present(dialogMessage, animated: true, completion: nil)
        }
        
    }

    

    @IBAction func loginButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "newlogin")
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated:true)
    }
    
}
