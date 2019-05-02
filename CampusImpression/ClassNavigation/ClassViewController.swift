//
//  ClassViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/14/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit
import Firebase

class ClassViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var ClassCollectionView: UICollectionView!
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!

    
    var class_list = [String]()
    var course_ref: DocumentReference!
    var current_course = [String]()
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
        layout.itemSize = CGSize(width: (self.ClassCollectionView.frame.size.width - 20)/2, height: self.ClassCollectionView.frame.size.height/3)
        
        guard let userid = Auth.auth().currentUser?.uid else {return}
        course_ref = Firestore.firestore().collection("users").document(userid)
    }
    
    
    // fetching course from data base
    func getcourse(){
        course_ref.getDocument { (data, error) in
            if let err = error {
                debugPrint("Error fetching course:\(err)")
            }else {
                self.class_list = data?.get("course") as! [String]
                self.ClassCollectionView.reloadData()
            }
            self.ClassCollectionView.reloadData()
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
        return class_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassCell", for: indexPath) as! ClassCollectionViewCell
        
        cell.ClassLabel.text = class_list[indexPath.row]
        cell.layer.cornerRadius = 4
        cell.layer.masksToBounds = true
        
        if editMode == ON {
            cell.deleteButton.isHidden = false
        } else {
            cell.deleteButton.isHidden = true
        }
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if editMode == true {
            remove_course(index: indexPath.row)
        } else {
            self.performSegue(withIdentifier: "NavSegue", sender: nil)
        }
    }
    
    func remove_course(index: Int){
        let userid = Auth.auth().currentUser?.uid
        var course_ref: DocumentReference!
        course_ref = Firestore.firestore().collection("users").document(userid!)
        course_ref.getDocument { (data, error) in
            if let err = error {
                debugPrint("Error fetching course:\(err)")
            }else {
                self.current_course = data?.get("course") as! [String]
                self.current_course.remove(at: index)
                Firestore.firestore().collection("users").document(userid!).setData(["course" : self.current_course], merge: true)
                self.class_list = self.current_course
            }
            self.ClassCollectionView.reloadData()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getcourse()
    }
    
    
    
}
