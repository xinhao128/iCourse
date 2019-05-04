//
//  TutorViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/14/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Firebase

class TutorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tutor_list = [[String]]()
    var tutor_name = "unKnown"
    var pass_name = String()
    var tutorCollectionRef: CollectionReference!
    var tutorName: String!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    
    }
    
    func loadTutors() {
        tutorCollectionRef = Firestore.firestore().collection("COURSES").document("P29HX1EFUdptpwR3HWfu").collection("course").document("3weuRiGVQoNoAZvSJ6MR").collection("tutor_list")
        gettutors()
    }
    
    func gettutors(){
        self.tutor_list = [[String]]()
        tutorCollectionRef.getDocuments { (data, error) in
            if let err = error {
                debugPrint("Error fetching tutors:\(err)")
            }else {
                self.list_of_tutor(lm: (data?.documents)!)
            }
        }
    }
    
    func list_of_tutor(lm: [QueryDocumentSnapshot]){
        
        for document in lm {
            let uid = (document.data())["tutor_name"] as! String
            var usernameRef: DocumentReference!
            usernameRef = Firestore.firestore().collection("users").document(uid)
            usernameRef.getDocument { (username, error) in
                if let err = error {
                    debugPrint("Error fetching course:\(err)")
                }else {
                    self.tutor_name = username?.get("username") as! String
                    self.tableView.reloadData()
                }
                self.tutor_list.append([(document.data())["office_hour"] as! String, self.tutor_name])
                self.tableView.reloadData()
            }
        }
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutor_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tutor = tutor_list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TutorCell") as! TutorCell
        
        cell.tutorName.text = tutor[1]
        cell.officeHours.text = tutor[0]
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let tutor = tutor_list[indexPath.row]
//        tutorName = (tutor[1] as! String)
//        self.performSegue(withIdentifier: "TutoringSegue", sender: nil)
//    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadTutors()
    }
    
    @IBAction func applytutorBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "apply_tutor", sender: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let tutorCoursesTableViewController = segue.destination as? TutorCoursesTableViewController {
//            tutorCoursesTableViewController.about = self.tutorName
//        }
//    }
    
}
