//
//  TutorViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/14/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Parse

class TutorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tutors = [PFObject]()
    var tutorName: String!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        loadTutors()
    }
    
    func loadTutors() {
        let query = PFQuery(className: "Tutor")
        query.includeKey("tutorName")
        query.limit = 20
        query.findObjectsInBackground { (tutors, error) in
            if tutors != nil {
                self.tutors = tutors!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tutor = tutors[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TutorCell") as! TutorCell
        
        cell.tutorName.text = (tutor["tutorName"] as! String)
        cell.officeHours.text = (tutor["officeHours"] as! String)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tutor = tutors[indexPath.row]
        tutorName = (tutor["tutorName"] as! String)
        self.performSegue(withIdentifier: "TutoringSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tutorCoursesTableViewController = segue.destination as? TutorCoursesTableViewController {
            tutorCoursesTableViewController.about = self.tutorName
        }
    }

}
