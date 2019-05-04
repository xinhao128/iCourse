//
//  PersonalSettingsTableViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/3/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Firebase

class PersonalSettingsTableViewController: UITableViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel?
    @IBOutlet weak var birthdayLabel: UILabel?
    @IBOutlet weak var hometownLabel: UILabel?
    @IBOutlet weak var majorLabel: UILabel?

    var userInfo_Ref: DocumentReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.cornerRadius = 15.0
        profileImageView.layer.masksToBounds = true
        
        
        loadUser()
    }

    func loadUser() {
        let user = Auth.auth().currentUser!
        userInfo_Ref = Firestore.firestore().collection("users").document(user.uid)
        self.usernameLabel.text = user.displayName as! String
        self.emailLabel.text = user.email as! String
        userInfo_Ref.getDocument { (data, error) in
            if let err = error {
                debugPrint("Error fetching course:\(err)")
            }else {
                self.genderLabel?.text = data?.get("gender") as! String
                self.birthdayLabel?.text = data?.get("birthday") as! String
                self.hometownLabel?.text = data?.get("hometown") as! String
                self.majorLabel?.text = data?.get("major") as! String
            }
        }
    }

}
