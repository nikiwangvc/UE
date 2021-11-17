//
//  NewSignUpViewController.swift
//  UE
//
//  Created by Niki Wang on 11/16/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseCore
import FirebaseFirestore
//import FirebaseFirestoreSwift

class NewSignUpViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // [START setup]
        let settings = FirestoreSettings()

        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }

    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        if email.text?.isEmpty == true {
            print("Please enter your email.")
            // Create new Alert
            let dialogMessage = UIAlertController(title: "Attention", message: "Please enter your email", preferredStyle: .alert)
            
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
        if password.text?.isEmpty == true {
            print("Please enter your password.")
            // Create new Alert
            let dialogMessage = UIAlertController(title: "Attention", message: "Please enter your password", preferredStyle: .alert)
            
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
        signUp()
    }
    
    
    @IBAction func loginPage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "newlogin")
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated:true)
    }
    
    func signUp(){
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authResult,error)in
            guard let users = authResult?.user,error == nil else{
                print("Error \(error?.localizedDescription)")
                return
            }
            print("UID \(Auth.auth().currentUser?.uid)")
            db.collection("users").document(Auth.auth().currentUser?.uid).setData([
                "email": email.text!
            ])
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RecordTripsViewController")
            vc?.modalPresentationStyle = .overFullScreen
            self.present(vc!,animated:true)
        }
    }
}
