//
//  PersonalSettingsTableViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/3/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Parse

class PersonalSettingsTableViewController: UITableViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel?
    @IBOutlet weak var birthdayLabel: UILabel?
    @IBOutlet weak var hometownLabel: UILabel?
    @IBOutlet weak var majorLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.cornerRadius = 15.0
        profileImageView.layer.masksToBounds = true
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
                self.genderLabel?.text = (profile![0]["gender"] as? String)
                self.birthdayLabel?.text = (profile![0]["birthday"] as? String)
                self.hometownLabel?.text = (profile![0]["hometown"] as? String)
                self.majorLabel?.text = (profile![0]["major"] as? String)
            }
            else {
                print("fetch error")
            }
        }
    }

}
