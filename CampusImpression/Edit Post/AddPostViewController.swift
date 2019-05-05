//
//  AddPostViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/5/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class AddPostViewController: UIViewController {

    var tagText: String!
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var postContents: UITextView!
    
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var tagStudy: UIButton!
    @IBOutlet weak var tagLife: UIButton!
    @IBOutlet weak var tagEntertainment: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postContents.layer.borderWidth = 1
        postContents.layer.cornerRadius = 5
        postContents.layer.borderColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1).cgColor
        
        tagStudy.addTarget(self, action: #selector(tagClicked), for:.touchUpInside)
        tagLife.addTarget(self, action: #selector(tagClicked), for:.touchUpInside)
        tagEntertainment.addTarget(self, action: #selector(tagClicked), for:.touchUpInside)
    }
    
    @objc func tagClicked(sender: UIButton) {
        switch sender.tag {
        case 0:
            self.tagText = "Homework"
            changeColor(tag: 0)
        case 1:
            self.tagText = "Exam"
            changeColor(tag: 1)
        case 2:
            self.tagText = "General"
            changeColor(tag: 2)
        default:
            print("default")
        }
    }
    
    func changeColor(tag: Int) {
        for view in self.tagView.subviews {
            if let btn = view as? UIButton {
                if (btn.tag == tag) {
                    btn.setTitleColor(UIColor.white, for: [])
                    btn.backgroundColor = UIColor(red: 244/255, green: 128/255, blue: 36/255, alpha: 1.0)
                }
                else {
                    btn.setTitleColor(UIColor(red: 244/255, green: 128/255, blue: 36/255, alpha: 1.0), for: [])
                    btn.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 235/255, alpha: 1.0)
                }
            }
        }
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addPostImageViewController = segue.destination as! AddPostImageViewController
        addPostImageViewController.postTitle = postTitle.text!
        addPostImageViewController.postContents = postContents.text!
        addPostImageViewController.tag = self.tagText!
    }

}
