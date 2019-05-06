//
//  ProfileConfigTableViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/3/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Parse

class ProfileConfigTableViewController: UITableViewController {

    @IBOutlet weak var profilePhotoView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePhotoView.layer.cornerRadius = 25.0
        profilePhotoView.layer.masksToBounds = true
        loadUser()
    }
    
    func loadUser() {
        let query = PFQuery(className: "Profiles")
        query.includeKey("user")
        query.whereKey("user", equalTo: PFUser.current()!)
        query.findObjectsInBackground { (profile, error) in
            if profile != nil {
                let user = profile![0]["user"] as! PFUser
                self.usernameLabel.text = user["username"] as? String
                self.emailLabel.text = (profile![0]["UCIEmail"] as! String)
            }
            else {
                print("fetch error")
            }
        }
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.window?.rootViewController = loginViewController
    }
    
}
