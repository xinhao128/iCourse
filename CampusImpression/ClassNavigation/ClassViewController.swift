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
            addBarButtonItem.isEnabled = false
            ClassCollectionView.reloadData()
        } else {
            editMode = OFF
            editButton.title = "Edit"
            addBarButtonItem.isEnabled = true
            ClassCollectionView.reloadData()
        }
    }
    
    // CollectionView Function
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassCell", for: indexPath) as! ClassCollectionViewCell
        
        let course = courses[indexPath.item]
        cell.ClassLabel.text = course["courseTitle"] as? String
        
        cell.layer.backgroundColor = UIColor(red: 255/255, green: 210/255, blue: 0/255, alpha: 1.0).cgColor
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
        cell.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1.0)
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        
        cell.delegate = self
        
        if editMode == OFF {
            cell.deleteButton.isHidden = true
        } else {
            cell.deleteButton.isHidden = false
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let course = courses[indexPath.item]
        let courseTitle = (course["courseTitle"] as! String)
        UserDefaults.standard.set(courseTitle, forKey: "courseTitle")
        if editMode == OFF {
            self.performSegue(withIdentifier: "NavSegue", sender: nil)
        }
    }
}

extension ClassViewController: ClassCellDelegate {
    func delete(cell: ClassCollectionViewCell) {
        if let indexPath = ClassCollectionView?.indexPath(for: cell) {
            let course = courses[indexPath.item]
            let courseTitle = (course["courseTitle"] as! String)

            let query = PFQuery(className: "Courses")
            query.includeKeys(["user", "courseTitle"])
            
            query.whereKey("user", equalTo: PFUser.current()!).whereKey("courseTitle", equalTo: courseTitle)
            query.findObjectsInBackground { (objects, error) in
                if let objects = objects {
                    print("\(objects) empty")
                    for object in objects {
                        print(object)
                        object.deleteEventually()
                    }
                }
            }
            courses.remove(at: indexPath.item)
            ClassCollectionView.reloadData()
        }
    }
}
