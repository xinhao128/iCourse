//
//  ClassViewController.swift
//  CampusImpression
//
//  Created by Xinhao Liang on 3/14/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import UIKit

class ClassViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var ClassCollectionView: UICollectionView!
    
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var editButton: UIBarButtonItem!

    
    var class_list = ["ICS 31","EECS 180A", "ECON 20B"]
    
    let OFF = false
    let ON = true
    
    let defaults = UserDefaults.standard
    
    func test() {
        
        let placeHolderValue = 1000
        let userDefaults = UserDefaults.standard
        userDefaults.set(placeHolderValue, forKey: "placeholder")
    }
    
    var editMode: Bool!
    
    var class_image_list: [UIImage] = [
        UIImage(named:"ICS 31")!,
        UIImage(named:"EECS 180A")!,
        UIImage(named:"ECON 20B")!,
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ClassCollectionView.dataSource = self
        ClassCollectionView.delegate = self
        
        editMode = OFF
        
        let layout = self.ClassCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0,left: 5,bottom: 0,right: 5)
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: (self.ClassCollectionView.frame.size.width - 20)/2, height: self.ClassCollectionView.frame.size.height/3)
        
        print("\n\nEditing mode: ", editMode)
        
        // Do any additional setup after loading the view.
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
        return class_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassCell", for: indexPath) as! ClassCollectionViewCell
        
        cell.ClassLabel.text = class_list[indexPath.row]
        cell.ClassImageView.image = class_image_list[indexPath.item]
        cell.layer.cornerRadius = 4
        cell.layer.masksToBounds = true
        
        if editMode == ON {
            cell.deleteButton.isHidden = false
            addBarButtonItem.isEnabled = false
        } else {
            cell.deleteButton.isHidden = true
            addBarButtonItem.isEnabled = true
        }
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        
        //        cell.delegate = self as! ClassCellDelegate
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if editMode == true {
            class_list.remove(at: indexPath.row)
            ClassCollectionView.reloadData()
        } else {
            self.performSegue(withIdentifier: "NavSegue", sender: nil)
        }
        //        else{
        //            defaults.set(nil, forKey: "newClass")
        //            defaults.synchronize()
        //
        //            let newclassValue = defaults.string(forKey: "newClass")
        //            print("-------",newclassValue)
        //            if newclassValue != nil{
        //                class_list.append(newclassValue!)
        //                class_image_list.append(UIImage(named:"sample_1")!)
        //                ClassCollectionView.reloadData()
        //            }
        
    }


}
