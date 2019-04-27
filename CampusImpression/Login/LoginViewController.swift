//
//  LoginViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 2/23/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Firebase

extension UIViewController{

    func HideKeyboard() {
        let Tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))

        view.addGestureRecognizer(Tap)
    }

    @objc func DismissKeyboard() {

        view.endEditing(true)

    }
}

class LoginViewController: UIViewController {
 
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        
        self.HideKeyboard()
    }
    

    
    @IBAction func userLogin(_ sender: Any) {
        let email = usernameTextField.text!
        let password = passwordTextField.text!
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error  = error {
                print("error uid",error.localizedDescription)
            }else {
                print("success signed in")
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
        }
    }
}

