//  Created by Niki Wang and Jeffrey Kozik on 10/25/21.

import UIKit // for ui
//import Auth0 // for login

class ViewController: UIViewController{
    override func viewDidLoad(){
        super.viewDidLoad()
//        createButtons() // creates login button and location tracking button
    }
    

    @IBOutlet var Email: UITextField!
    @IBOutlet var Password: UITextField!
    
    
    @IBAction func Login(_ sender: Any) {
    }
    
    
    @IBAction func createAccountTapped(_ sender: Any) {
        //connect it with signin page
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "signup")
        vc.modalPresentationStyle = .overFullScreen
        present(vc,animated:true)
    }
    
    
    
    
    
    
    
    
    
    
    
    //    func createButtons(){
//        let button = UIButton(frame:CGRect(x: 0, y: 0, width: 150, height: 150))
//        button.center = view.center
//        button.configuration = .RecordButton()
//        //https://medium.com/doyeona/uibutton-swift-uiaction-closure-based-uicontrol-ios-14-405e255a7640
//        button.addTarget(self, action: #selector(recordTrip), for: .touchUpInside)
//        view.addSubview(button)
//        let loginButton = UIButton(frame:CGRect(x: 0, y: 200, width: 150, height: 150))
//        loginButton.configuration = .LoginButton()
//        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
//        view.addSubview(loginButton)
//    }
//
//    @objc func login(){
//        Auth0
//            .webAuth()
//            .scope("openid profile")
//            .audience("https://dev-zojyaz8i.us.auth0.com/userinfo")
//            .start { result in
//                switch result {
//                case .failure(let error):
//                    // Handle the error
//                    print("Error: \(error)")
//                case .success(let credentials):
//                    // Do something with credentials e.g.: save them.
//                    // Auth0 will automatically dismiss the login page
//                    print("Credentials: \(credentials)")
//                }
//        }
//        print("logged in!!")
//    }
}

//using extension UIButton to add more buttons in the future
//extension UIButton.Configuration{
//    static func RecordButton() -> UIButton.Configuration{
//        var config: UIButton.Configuration = .filled()
//        config.baseBackgroundColor = .systemOrange
//        config.title = "Start"
//        config.subtitle = "Recording"
//        config.cornerStyle = .large
//        //assign true to show activity using a spinner
//        config.showsActivityIndicator = false
//        return config
//    }
//    static func LoginButton() -> UIButton.Configuration{
//        var config: UIButton.Configuration = .filled()
//        config.baseBackgroundColor = .systemOrange
//        config.title = "Login"
//        config.cornerStyle = .large
//        //assign true to show activity using a spinner
//        config.showsActivityIndicator = false
//        return config
//    }
//}
