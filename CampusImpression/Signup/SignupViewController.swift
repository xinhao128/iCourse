//
//  SignupViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 2/23/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var UCIEmailField: UITextField!
    @IBOutlet weak var emailValidated: UIImageView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var passwordValidated: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    var activeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.isSecureTextEntry = true
        confirmPasswordField.isSecureTextEntry = true
        
        usernameField!.delegate = self
        passwordField!.delegate = self
        UCIEmailField!.delegate = self
        confirmPasswordField!.delegate = self
        self.HideKeyboard()
        
        for case let subview as UITextField in self.view.subviews {
            subview.addBottomBorder()
            subview.textColor = UIColor.white
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let center: NotificationCenter = NotificationCenter.default;
        center.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        let keyboardY = self.view.frame.size.height - keyboardSize.height
        
        let editingTextFieldY: CGFloat! = self.activeTextField.frame.origin.y
        
        // Checking if the textfield is really hidden behind the keyboard
        if self.view.frame.origin.y >= 0 {
            if editingTextFieldY > keyboardY - 60 {
                UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn,
                               animations: {
                                self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editingTextFieldY - (keyboardY - 60)), width: self.view.bounds.width, height: self.view.bounds.height)
                }, completion: nil)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn,
                       animations: {
                        self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
    }
    
    @IBAction func backToSigninBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func validateUCIEmail(_ sender: Any) {
        
        // need Google Access Token
        
//        let url = URL(string: "https://www.googleapis.com/gmail/v1/users/\(UCIEmailField.text!)/profile")!
//        print(url)
//        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
//        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
//        let task = session.dataTask(with: request) { (data, response, error) in
//            // This will run when the network request returns
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                let statusCode = (response as! HTTPURLResponse).statusCode
//                if statusCode == 200 {
//                    print("email verified")
//                }
//                else {
//                    print("invalid UCI email address")
//                }
//            }
//        }
//        task.resume()
//        if (isValidEmail(testStr: UCIEmailField.text!)) {
//            print("verified")
//        }
        
        // temporary function
        if (UCIEmailField.text?.contains("uci.edu") ?? nil)! {
            let image: UIImage = UIImage(named: "checkBtn")!
            emailValidated.image = image
        }
        else {
            emailValidated.image = nil
        }
    }
    
    @IBAction func confirm(_ sender: Any) {
        if passwordField.text == confirmPasswordField.text && passwordField.text != "" {
            let image: UIImage = UIImage(named: "checkBtn")!
            passwordValidated.image = image
        }
        else {
            passwordValidated.image = nil
        }
    }

    @IBAction func goNext(_ sender: Any) {
        if (usernameField.text!.isEmpty) || (passwordField.text!.isEmpty) || (passwordField.text!.isEmpty) || (UCIEmailField.text!.isEmpty) {
           print("error")
        }
        else {
            self.performSegue(withIdentifier: "ContSignupSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let signup2ViewController = segue.destination as! Signup2ViewController
        signup2ViewController.usernameField = usernameField.text!
        signup2ViewController.passwordField = passwordField.text!
        signup2ViewController.UCIEmailField = UCIEmailField.text!
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
