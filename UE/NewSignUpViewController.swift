//  Created by Niki Wang on 11/16/21.

import UIKit
import FirebaseAuth
import Firebase
import FirebaseCore
import FirebaseFirestore

class NewSignUpViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    var db: Firestore!
    let defaults = UserDefaults.standard

    @IBOutlet var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+50)
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
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
    
    
<<<<<<< HEAD:UE/NewSignUpViewController.swift
    @IBAction func loginPage(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "newlogin")
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated:true)
=======
    @IBAction func login(_ sender: Any) {
//        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
//        let loginViewController = mainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        loginViewController.modalPresentationStyle = .overFullScreen
//        self.present(loginViewController,animated:true, completion: nil)
>>>>>>> main:UE/SignupViewController.swift
    }
    
    func signUp(){
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authResult,error)in
            guard let users = authResult?.user,error == nil else{
                print("Error \(error?.localizedDescription)")
                return
            }
            print("UID \(Auth.auth().currentUser?.uid)")
            let uidString = Auth.auth().currentUser?.uid
            self.defaults.set(Auth.auth().currentUser!.uid, forKey: "uid")
            self.db.collection("users").document(uidString!).setData([
                "email": self.email.text!,
                "autoTripTracking": false,
                "distanceUnit": "miles",
                "sustainabilityUnit": "co2",
                "friendsEmails": [],
                "iHaveNotAcceptedYet": [],
                "theyHaveNotAcceptedYet": [],
                "co2": 0,
                "kilometersTraveled": 0,
                "formOfTransport": 0,
                "secondsElapsed": 0,
                "tripInProgress": false,
                "dayCO2": 0,
                "weekCO2": 0,
                "totalCO2": 0,
                "graphScale": "week",
                "numTrips": 0
            ])
            self.db.collection("users").document(uidString!).collection("trips").document("document").setData([
                "1": []
            ])
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController")
            vc?.modalPresentationStyle = .overFullScreen
            self.present(vc!,animated:true)
        }
    }
}
