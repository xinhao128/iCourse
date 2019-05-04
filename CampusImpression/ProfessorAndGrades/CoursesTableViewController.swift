//
//  CoursesTableViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/15/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Firebase

class CoursesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//    let courses: [String] = ["ICS 33", "ECON 20B", "EECS 180B"]
//    let professors: [String] = ["Richard E. Pattis", "Pathik D. Wadhwa", "Henry Lee"]
//    let offices: [String] = ["Office: DBH 4062", "Office: SSPB 3279", "Office: DBH 6042"]
//    let phones: [String] = ["Phone: 949-824-2704", "Phone: 949-824-8238", "Phone: 949-824-3148"]
//    let researches:[String] = ["Microworlds for teaching programming; computational tools for non computer scientists", "fetal/developmental programming of health and disease risk", "fiber-optics and compound semiconductor technology"]
//    var urls: [String] = ["https://www.ics.uci.edu/~pattis/images/pattis.jpg", "https://img.etimg.com/photo/59693971/wadhwa-group-ushers-in-luxury-with-project-w54-in-matunga.jpg","https://www.faculty.uci.edu/ext_img/faculty/5710.jpg"]
    
    
    var prof_list = [["unknown","unknown"]]
    var prof_name = "unknown"
    var proInfoRef: CollectionReference!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadprof()
    }
    
    // load professor
    func loadprof() {
        proInfoRef = Firestore.firestore().collection("COURSES").document("P29HX1EFUdptpwR3HWfu").collection("course").document("3weuRiGVQoNoAZvSJ6MR").collection("professor_list")
        print("professor",prof_name)
        getProfessor()
    }
    
    func getProfessor(){
        self.prof_list = [[String]]()
        proInfoRef.getDocuments { (data, error) in
            if let err = error {
                debugPrint("Error fetching tutors:\(err)")
            }else {
                self.list_of_prof(lm: (data?.documents)!)
            }
        }
    }
    
    func list_of_prof(lm: [QueryDocumentSnapshot]){
//        print("document_s",lm)
        for document in lm {
            
//            let uid = (document.data())["name"] as! String
//            var usernameRef: DocumentReference!
//            usernameRef = Firestore.firestore().collection("users").document(uid)
//            usernameRef.getDocument { (username, error) in
//                if let err = error {
//                    debugPrint("Error fetching course:\(err)")
//                }else {
//                    self.prof_name = username?.get("username") as! String
//
//                    self.tableView.reloadData()
//                }
//                self.prof_list.append([uid, self.prof_name])
//                self.tableView.reloadData()
//            }
        }
    }
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prof_list.count
    }
    
    // Design the TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let prof = prof_list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath) as! CourseCell
        let professorname = prof[1]
        cell.professorname.text = professorname
        
        return cell
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let cell = sender as! UITableViewCell
//        let indexPath = tableView.indexPath(for: cell)!
//
//        let professorInfoController = segue.destination as! ProfessorInfoController
//        professorInfoController.profUid = prof_list[indexPath.row][0]
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }

}
