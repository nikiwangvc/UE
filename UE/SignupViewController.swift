//
//  SignupViewController.swift
//  UE
//
//  Created by Niki Wang on 11/15/21.
//

import UIKit
import AuthenticationServices

class SignupViewController: UIViewController {


    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signup(_ sender: Any) {
    }
    

//    //@IBAction func loginAccountTapped(_ sender: Any) {
//        let storyboard = UIStoryboard(name:"Main",bundle:nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "login")
//        vc.modalPresentationStyle = .overFullScreen
//        present(vc,animated: true)
//    }
//

}
