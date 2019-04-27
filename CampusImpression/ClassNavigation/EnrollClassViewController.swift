//
//  EnrollClassViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/14/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class EnrollClassViewController: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {

    var currentTextField = UITextField()
    let pickerView = UIPickerView()

    let department_list = ["ECON","ICS","EECS"]
    let course_number_list = ["20B","31","180A"]

    
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
    
    func addDoneButtonOnKeyboard() {
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
        //        self.currentTextField.resignFirstResponder()
        self.view.endEditing(true)
        if currentTextField == departmentField {
            let selectedValue = department_list[pickerView.selectedRow(inComponent: 0)]
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
            print(course_number_list.count)
            return course_number_list.count
        }
        else if currentTextField == departmentField {
            return department_list.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == departmentField{
            return department_list[row]
        }
        else if currentTextField == courseField{
            return course_number_list[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == departmentField{
            departmentField!.text =  department_list[row]
        }
        else if currentTextField == courseField{
            courseField!.text =  course_number_list[row]
        }
    }
    
    @IBAction func onEnrollClass(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        
        print("-------department",departmentField!.text!)
        print("-------classnumber",courseField!.text!)
        let newclass = departmentField!.text! + " " + courseField!.text!
        print("-------newclass",newclass)
        UserDefaults.standard.set(newclass, forKey: "newClass")
        UserDefaults.standard.synchronize()
    }
    
    
    @IBAction func onCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
