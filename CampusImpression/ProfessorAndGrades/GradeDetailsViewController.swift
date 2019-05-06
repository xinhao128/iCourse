//
//  GradeDetailsViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/15/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class GradeDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {

    @IBOutlet weak var quarterPicker: UIPickerView!
    @IBOutlet weak var percentageForA: UILabel!
    @IBOutlet weak var percentageForB: UILabel!
    @IBOutlet weak var percentageForC: UILabel!
    @IBOutlet weak var gradeView: UIImageView!
    
    var pickerData: [String] = ["2018 Fall", "2018 Winter"]
    var percentagesA: [String] = ["37/144   26%", "41/273    15%"]
    var percentagesB: [String] = ["99/144   69%", "128/273   47%"]
    var percentagesC: [String] = ["7/144    5%", "76/273    28%"]
    override func viewDidLoad() {
        super.viewDidLoad()
        quarterPicker.dataSource = self
        quarterPicker.delegate = self
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        percentageForA.text = percentagesA[row]
        percentageForB.text = percentagesB[row]
        percentageForC.text = percentagesC[row]
        gradeView.image = UIImage(named: "grades")
    }
    
}
