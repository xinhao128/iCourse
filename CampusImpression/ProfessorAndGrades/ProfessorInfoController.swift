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
    
    
    var ProfessorName: String = ""
    var ProfessorOffice: String = ""
    var ProfessorPhone: String = ""
    var ProfessorResearch: String = ""
    var ProfessorPhoto: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        professorName.text = ProfessorName
        professorOffice.text = ProfessorOffice
        professorPhone.text = ProfessorPhone
        professorResearch.text = ProfessorResearch
        let posterPath = ProfessorPhoto
        let posterUrl = URL(string: posterPath)
        professorPhoto.af_setImage(withURL: posterUrl!)

        gradeView.image = UIImage(named: "grades")!
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
