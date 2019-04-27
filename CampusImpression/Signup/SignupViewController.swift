//
//  SignupViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 2/23/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var UCIEmailField: UITextField!
    @IBOutlet weak var emailValidated: UIImageView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var passwordValidated: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordField.isSecureTextEntry = true
        confirmPasswordField.isSecureTextEntry = true

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
        if passwordField.text == confirmPasswordField.text {
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
}
