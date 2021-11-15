//
//  SignupViewController.swift
//  UE
//
//  Created by Niki Wang on 11/15/21.
//

import UIKit
import AuthenticationServices

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var Email: UITextField!
    
    @IBOutlet var Password: UITextField!


    @IBAction func signup(_ sender: Any) {
    }
    

    @IBAction func loginAccountTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name:"Main",bundle:nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated: true)
    }
    




    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
