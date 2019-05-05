//
//  TutorCoursesTableViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/14/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class TutorCoursesTableViewController: UITableViewController {

    var about: String!
    @IBOutlet weak var tutorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tutorLabel.text = "About " + about
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorAboutTableViewController = segue.destination as? TutorAboutTableViewController {
            tutorAboutTableViewController.name = self.about
        }
    }

}
