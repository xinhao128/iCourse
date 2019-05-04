//
//  ProfessorInfoController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/15/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class ProfessorInfoController: UIViewController {
    
    @IBOutlet weak var professorPhoto: UIImageView!
    @IBOutlet weak var professorName: UILabel!
    @IBOutlet weak var professorOffice: UILabel!
    @IBOutlet weak var professorPhone: UILabel!
    @IBOutlet weak var professorResearch: UILabel!
    @IBOutlet weak var gradeView: UIImageView!
    
    
//    var  profInoRef: Collection
    
//    func loadTutors() {
//        tutorCollectionRef = Firestore.firestore().collection("COURSES").document("P29HX1EFUdptpwR3HWfu").collection("course").document("3weuRiGVQoNoAZvSJ6MR").collection("tutor_list")
//        gettutors()
//    }
    
    var profUid : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        professorName.text = ProfessorName
//        professorOffice.text = ProfessorOffice
//        professorPhone.text = ProfessorPhone
//        professorResearch.text = ProfessorResearch
//        let posterPath = ProfessorPhoto
//        let posterUrl = URL(string: posterPath)
//        professorPhoto.af_setImage(withURL: posterUrl!)

        gradeView.image = UIImage(named: "grades")!
        // Do any additional setup after loading the view.
    }
    
}
