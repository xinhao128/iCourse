//
//  ClassViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/14/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Parse

class ClassViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var ClassCollectionView: UICollectionView!
    
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var editButton: UIBarButtonItem!

    var courses = [PFObject]()
    //var currentCourse: String!
    
    let OFF = false
    let ON = true
    
    var editMode: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ClassCollectionView.dataSource = self
        ClassCollectionView.delegate = self
        
        editMode = OFF
        
        let layout = self.ClassCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 5)
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: (self.ClassCollectionView.frame.size.width - 20)/2, height: self.ClassCollectionView.frame.size.height/4)
        
        print("\n\nEditing mode: ", editMode)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let query = PFQuery(className: "Courses")
        query.includeKey("user")
        
        query.whereKey("user", equalTo: PFUser.current()!)
        query.findObjectsInBackground{ (courses, error) in
            if courses != nil {
                self.courses = courses!
                self.ClassCollectionView.reloadData()
            }
        }
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        if editMode == OFF {
            editMode = ON
            editButton.title = "Done"
            ClassCollectionView.reloadData()
        } else {
            editMode = OFF
            editButton.title = "Edit"
            ClassCollectionView.reloadData()
        }
    }
    
    // CollectionView Function
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassCell", for: indexPath) as! ClassCollectionViewCell
        
        let course = courses[indexPath.row]
        cell.ClassLabel.text = course["courseTitle"] as? String
        
        cell.layer.backgroundColor = UIColor(red: 255/255, green: 210/255, blue: 0/255, alpha: 1.0).cgColor
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        
        if editMode == ON {
            cell.deleteButton.isHidden = false
            addBarButtonItem.isEnabled = false
        } else {
            cell.deleteButton.isHidden = true
            addBarButtonItem.isEnabled = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if editMode == true {
            courses.remove(at: indexPath.row)
            ClassCollectionView.reloadData()
        } else {
            let course = courses[indexPath.row]
            let courseTitle = (course["courseTitle"] as! String)
            UserDefaults.standard.set(courseTitle, forKey: "courseTitle")

            self.performSegue(withIdentifier: "NavSegue", sender: nil)
        }
    }
    
}
