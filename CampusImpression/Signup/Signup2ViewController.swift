//
//  Signup2ViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 2/23/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Firebase



class Signup2ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var usernameField: String?
    var UCIEmailField: String?
    var passwordField: String?
    var inputText: String?
    
    var currentTextField = UITextField()
    
    var currentItem = ""
    
    let pickerView = UIPickerView()
    let datePicker = UIDatePicker()
    
    var gender = ["male", "female"]
    var major = [String]()
    var majorCollectionRef: CollectionReference!
    
    
    
    @IBOutlet weak var genderField: UITextField?
    @IBOutlet weak var majorField: UITextField?
    @IBOutlet weak var birthdayField: UITextField?
    @IBOutlet weak var hometownField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        currentTextField.delegate = self
        genderField?.delegate = self
        majorField?.delegate = self
        
        
        createPickers()
        addDoneButtonOnKeyboard()
        
    }

    // fetching data from db
    func fetch_major(){
        majorCollectionRef = Firestore.firestore().collection("MAJORS")
        majorCollectionRef.getDocuments { (majors, error) in
            if let err = error {
                debugPrint("Error fetching majors:\(err)")
            }else {
                self.major = list_of_value(lm: (majors?.documents)!, key: "major_name")
            }
        }
    }
    
    
    func addDoneButtonOnKeyboard() {
        fetch_major()
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle       = UIBarStyle.default
        let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.birthdayField!.inputAccessoryView = doneToolbar
        self.genderField!.inputAccessoryView = doneToolbar
        self.majorField!.inputAccessoryView = doneToolbar
        self.hometownField!.inputAccessoryView = doneToolbar
    }
    
    // User clicks 'Done' button
    @objc func doneButtonAction() {
//        self.currentTextField.resignFirstResponder()
        self.view.endEditing(true);
        if currentTextField == genderField {
            let selectedValue = gender[pickerView.selectedRow(inComponent: 0)]
            genderField!.text = selectedValue
        }
        else if currentTextField == majorField {
            let selectedValue = major[pickerView.selectedRow(inComponent: 0)]
            majorField!.text = selectedValue
        }
        
    }

    func createPickers() {
        genderField?.inputView = pickerView
        majorField?.inputView = pickerView
        
        birthdayField?.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(Signup2ViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Signup2ViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(gestureRecognizer: UIGestureRecognizer) {
        view.endEditing(true)
    }
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        birthdayField?.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == genderField {
            return gender.count
        }
        else if currentTextField == majorField {
            return major.count
        }
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == genderField {
            return gender[row]
        }
        else if currentTextField == majorField {
            return major[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if currentTextField == genderField {
            genderField?.text = gender[row]
        }
        else if currentTextField == majorField {
            majorField?.text = major[row]
        }
    }
    
    @IBAction func onSignup(_ sender: Any) {

        guard let email = self.UCIEmailField,
            let password = self.passwordField,
            let username = self.usernameField else {return}
        
    
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint("Error creating user: \(error.localizedDescription)")
            }

            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges(completion: { (error) in
                if let error = error{
                    print("error change request",error.localizedDescription)
                }
            })

            guard let userId = Auth.auth().currentUser?.uid else {return}
            Firestore.firestore().collection(USERS_REF).document(userId).setData([
                USERNAME: username,
                DATE_CREATED : FieldValue.serverTimestamp(),
                BIRTHDAY : self.birthdayField?.text ?? "Unkown",
                GENDER : self.genderField?.text ?? "Unkown",
                HOMETOWN: self.hometownField?.text ?? "Unkown",
                MAJOR: self.majorField?.text ?? "Unkown"
                ],completion: { (error) in
                    if let error = error {
                        print("error uid",error.localizedDescription)
                    }else{
                        self.performSegue(withIdentifier: "SignupSegue", sender: nil)
//                        self.dismiss(animated: true, completion: nil)
                    }
            })
        
        }
    }
    
    
}


