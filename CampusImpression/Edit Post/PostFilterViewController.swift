//
//  PostFilterViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/7/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class PostFilterViewController: UIViewController {
    
    var filter: String!
    @IBOutlet weak var tagAll: UIButton!
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var tagHW: UIButton!
    @IBOutlet weak var tagExam: UIButton!
    @IBOutlet weak var tagGeneral: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tagHW.addTarget(self, action: #selector(tagClicked), for:.touchUpInside)
        tagExam.addTarget(self, action: #selector(tagClicked), for:.touchUpInside)
        tagGeneral.addTarget(self, action: #selector(tagClicked), for:.touchUpInside)
        tagAll.addTarget(self, action: #selector(tagClicked), for:.touchUpInside)
        
        loadButtonColor()
        
    }
    func loadButtonColor() {
        for view in self.view.subviews {
            if let btn = view as? UIButton {
                if btn.currentTitle! == UserDefaults.standard.string(forKey: "Filter") {
                    tagAll.setTitleColor(UIColor.white, for: [])
                    tagAll.backgroundColor = UIColor(red: 244/255, green: 128/255, blue: 36/255, alpha: 1.0)
                }
            }
        }
        for view in self.tagView.subviews {
            if let btn = view as? UIButton {
                if btn.currentTitle! == UserDefaults.standard.string(forKey: "Filter") {
                    btn.setTitleColor(UIColor.white, for: [])
                    btn.backgroundColor = UIColor(red: 244/255, green: 128/255, blue: 36/255, alpha: 1.0)
                }
            }
        }
    }
    
    @objc func tagClicked(sender: UIButton) {
        switch sender.tag {
        case 0:
            changeColorForOtherBtns()
            filter = "All"
        case 1:
            changeColorForCategory(tag: 1)
            filter = "Homework"
        case 2:
            changeColorForCategory(tag: 2)
            filter = "Exam"
        case 3:
            changeColorForCategory(tag: 3)
            filter = "General"
        default:
            filter = "All"
        }
    }
    
    func changeColorForOtherBtns() {
        tagAll.setTitleColor(UIColor.white, for: [])
        tagAll.backgroundColor = UIColor(red: 244/255, green: 128/255, blue: 36/255, alpha: 1.0)
        for view in self.tagView.subviews {
            if let btn = view as? UIButton {
                btn.setTitleColor(UIColor(red: 244/255, green: 128/255, blue: 36/255, alpha: 1.0), for: [])
                btn.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 235/255, alpha: 1.0)
            }
        }
    }
    
    func changeColorForCategory(tag: Int) {
        tagAll.setTitleColor(UIColor(red: 244/255, green: 128/255, blue: 36/255, alpha: 1.0), for: [])
        tagAll.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 235/255, alpha: 1.0)
        
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
    
    @IBAction func onDoneButton(_ sender: Any) {
        UserDefaults.standard.set(filter, forKey: "Filter")
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
