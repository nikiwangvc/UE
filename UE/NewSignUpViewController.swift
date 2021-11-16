//
//  NewSignUpViewController.swift
//  UE
//
//  Created by Niki Wang on 11/16/21.
//

import UIKit

class NewSignUpViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
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
    
}
