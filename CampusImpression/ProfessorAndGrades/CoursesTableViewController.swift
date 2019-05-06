//
//  CoursesTableViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/15/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class CoursesTableViewController: UITableViewController {
    
    let courses: [String] = ["ICS 33", "ECON 20B", "EECS 180B"]
    let professors: [String] = ["Richard E. Pattis", "Pathik D. Wadhwa", "Henry Lee"]
    let offices: [String] = ["Office: DBH 4062", "Office: SSPB 3279", "Office: DBH 6042"]
    let phones: [String] = ["Phone: 949-824-2704", "Phone: 949-824-8238", "Phone: 949-824-3148"]
    let researches:[String] = ["Microworlds for teaching programming; computational tools for non computer scientists", "fetal/developmental programming of health and disease risk", "fiber-optics and compound semiconductor technology"]
    var urls: [String] = ["https://www.ics.uci.edu/~pattis/images/pattis.jpg", "https://img.etimg.com/photo/59693971/wadhwa-group-ushers-in-luxury-with-project-w54-in-matunga.jpg","https://www.faculty.uci.edu/ext_img/faculty/5710.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    // Design the TableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as! CourseCell
        let courseName = courses[indexPath.row]
        let professorName = professors[indexPath.row]
        
        cell.courseName.text = courseName
        cell.professorName.text = professorName
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let professor = professors[indexPath.row]
        let professorOffice = offices[indexPath.row]
        let professorPhone = phones[indexPath.row]
        let professorResearch = researches[indexPath.row]
        let url = urls[indexPath.row]
        
        let professorInfoController = segue.destination as! ProfessorInfoController
        professorInfoController.ProfessorName = professor
        professorInfoController.ProfessorOffice = professorOffice
        professorInfoController.ProfessorPhone = professorPhone
        professorInfoController.ProfessorResearch = professorResearch
        professorInfoController.ProfessorPhoto = url
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
