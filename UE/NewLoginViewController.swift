//
//  NewLoginViewController.swift
//  UE
//
//  Created by Niki Wang on 11/16/21.
//

import UIKit
import FirebaseAuth
import Firebase

class NewLoginViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var forgotPassword: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+50)
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
    
    //a function to check whether the user has logged in previously
    //if logged in before then directly go to the distance travel page
    override func viewDidAppear(_ animated: Bool) {
        checkUserInfo()
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        validateLogin()
    }
    
    @IBAction func createSignUpTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewc = storyboard.instantiateViewController(withIdentifier: "newsignup")
        viewc.modalPresentationStyle = .overFullScreen
        present(viewc,animated:true)
        
    }
    
    func validateLogin(){
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
        
        login()
    }
    
    func login(){
        Auth.auth().signIn(withEmail: email.text!, password: password.text!){[weak self]authResult,err in
            guard let strongSelf = self else {
                print("RETURNING")
                return
            }
            print("strongSelf \(strongSelf)")
            if let err = err {
                print(err.localizedDescription)
            }
            self!.checkUserInfo()
    }
    
    }
    
    func checkUserInfo(){
        if Auth.auth().currentUser != nil{
            print("UID \(Auth.auth().currentUser?.uid)")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let viewc = storyboard.instantiateViewController(withIdentifier: "tabBarController")
            viewc.modalPresentationStyle = .overFullScreen
            present(viewc,animated:true)
        }
        else if email.text?.isEmpty == false {
                let dialogMessage = UIAlertController(title: "Wrong Email or Password", message: "Wrong Email or Password", preferredStyle: .alert)
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
    
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewc = storyboard.instantiateViewController(withIdentifier: "forgotPassword")
        viewc.modalPresentationStyle = .overFullScreen
        present(viewc,animated:true)
}
}
