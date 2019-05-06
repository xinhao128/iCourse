//
//  TutorAboutTableViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/15/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Parse

class TutorAboutTableViewController: UITableViewController {

    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var tutorName: UILabel!
    @IBOutlet weak var officeHours: UILabel!
    @IBOutlet weak var tutorEmail: UILabel!
    @IBOutlet weak var tutorPhone: UILabel!
    @IBOutlet weak var tutorBio: UILabel!
    
    var name: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePhoto.image = UIImage(named: "sample_1")!
        loadTutor()
    }
    
    func loadTutor() {
        let query = PFQuery(className: "Tutor")
        query.includeKey("tutorName")
        query.whereKey("tutorName", equalTo: name)
        query.findObjectsInBackground { (tutors, error) in
            if tutors != nil {
                self.tutorName.text = self.name
                self.officeHours.text = (tutors![0]["officeHours"] as! String)
                self.tutorEmail.text = (tutors![0]["email"] as! String)
                self.tutorPhone.text = (tutors![0]["phone"] as! String)
                self.tutorBio.text = (tutors![0]["bio"] as! String)
            }
            else {
                print("fetch error")
            }
        }
    }
}
