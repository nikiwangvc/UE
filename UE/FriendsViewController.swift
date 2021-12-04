//  Created by Jeffrey Kozik on 11/16/21.

import UIKit
import Firebase
import FirebaseAuth

//,UITableViewDataSource, UISearchBarDelegate
class FriendsViewController: UIViewController {
    
    //search bar in friends view controller
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friends"
        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        //https://github.com/codepath/ios_guides/wiki/Search-Bar-Guide
//        tableView.dataSource = self
//        searchBar.delegate = self
        view.addGestureRecognizer(tap)
    }

//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("ok")
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("ok")
//    }

    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
