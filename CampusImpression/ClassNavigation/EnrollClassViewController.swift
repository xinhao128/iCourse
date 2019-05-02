//
//  EnrollClassViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/14/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Firebase

class EnrollClassViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource{
    
    func delete_course(deletecourse: String){
        let userid = Auth.auth().currentUser?.uid
        var course_ref: DocumentReference!
        course_ref = Firestore.firestore().collection("users").document(userid!)
        course_ref.getDocument { (data, error) in
            if let err = error {
                debugPrint("Error fetching course:\(err)")
            }else {
                self.current_course = data?.get("course") as! [String]
                let index = self.current_course.index(of: deletecourse)
                Firestore.firestore().collection("users").document(userid!).setData(["course" : self.current_course.remove(at: index!)], merge: true)
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    var currentTextField = UITextField()
    let pickerView = UIPickerView()
    var departCollectionRef: CollectionReference!
    var course1CollectionRef: DocumentReference!
    var course2CollectionRef: CollectionReference!
    
    
    var department_list = [[String]]()
    var course_number_list = ["you have not selected department yet"]
    var current_course = [String]()

    
    @IBOutlet weak var departmentField: UITextField!
    @IBOutlet weak var courseField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        currentTextField.delegate = self
        departmentField!.delegate = self
        courseField!.delegate = self
        
        
        createPickers()
        addDoneButtonOnKeyboard()
        
    }
    
    // fetch department of course
    func fetch_depart(){
        departCollectionRef = Firestore.firestore().collection("COURSES")
        departCollectionRef.getDocuments { (departs, error) in
            if let err = error {
                debugPrint("Error fetching majors:\(err)")
            }else {
                self.department_list = list_of_value_with_uid(lm: (departs?.documents)!, key: "department")
            }
        }
        
    }
    
    // fetch title of course
    func fetch_num(courseid: String){
        course1CollectionRef = Firestore.firestore().collection("COURSES").document(courseid)
        course2CollectionRef = course1CollectionRef.collection("course")
        course2CollectionRef.getDocuments { (courses, error) in
            if let err = error {
                debugPrint("Error fetching majors:\(err)")
            }else {
//                //                print("type",type(of: majors))
                self.course_number_list = list_of_value(lm: (courses?.documents)!, key: "num")
//                print("num",courses?.documents)
            }
        }
        
    }
    
    func addDoneButtonOnKeyboard() {
        fetch_depart()
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.departmentField!.inputAccessoryView = doneToolbar
        self.courseField!.inputAccessoryView = doneToolbar
    }
    
    // User clicks 'Done' button
    @objc func doneButtonAction() {
        self.view.endEditing(true)
        if currentTextField == departmentField {
            let selectedValue = department_list[pickerView.selectedRow(inComponent: 0)][0]
            let courseID = department_list[pickerView.selectedRow(inComponent: 0)][1]
            fetch_num(courseid: courseID)
            departmentField!.text = selectedValue
        }
        else if currentTextField == courseField {
            let selectedValue = course_number_list[pickerView.selectedRow(inComponent: 0)]
            courseField!.text = selectedValue
        }
        
    }
    
    func createPickers() {
        departmentField!.inputView = pickerView
        courseField!.inputView = pickerView
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(EnrollClassViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(gestureRecognizer: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == courseField {
            return course_number_list.count
        }
        else if currentTextField == departmentField {
            return department_list.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == departmentField{
            return department_list[row][0]
        }
        else if currentTextField == courseField{
            return course_number_list[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == departmentField{
            departmentField!.text =  department_list[row][0]
        }
        else if currentTextField == courseField{
            courseField!.text =  course_number_list[row]
        }
    }
    
    @IBAction func onEnrollClass(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        
        let newcourse = departmentField!.text! + " " + courseField!.text!
        add_course(newcourse: newcourse)
    }
    
    
    func add_course(newcourse: String){
        let userid = Auth.auth().currentUser?.uid
        var course_ref: DocumentReference!
        course_ref = Firestore.firestore().collection("users").document(userid!)
        course_ref.getDocument { (data, error) in
            if let err = error {
                debugPrint("Error fetching course:\(err)")
            }else {
                self.current_course = data?.get("course") as! [String]
                self.current_course.append(newcourse)
                Firestore.firestore().collection("users").document(userid!).setData(["course" : self.current_course], merge: true)
                self.navigationController?.popViewController(animated: true)
            }
        }
        
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
