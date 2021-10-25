//
//  ViewController.swift
//  UE
//
//  Created by Niki Wang on 10/25/21.
//

import UIKit
import Auth0
class ViewController: UIViewController{
    override func viewDidLoad(){
        super.viewDidLoad()
        createButton()
    }
    func createButton(){
        let button = UIButton(frame:CGRect(x: 0, y: 0, width: 150, height: 150))
        button.center = view.center
        button.configuration = .RecordButton()
        view.addSubview(button)
    }
}
//using extension UIButton to add more buttons in the future
extension UIButton.Configuration{
    static func RecordButton() -> UIButton.Configuration{
        var config: UIButton.Configuration = .filled()
        config.baseBackgroundColor = .systemOrange
        config.title = "Start"
        config.subtitle = "Recording"
        config.cornerStyle = .large
        //assign true to show activity using a spinner
        config.showsActivityIndicator = false
        return config
    }
}
