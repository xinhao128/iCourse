//
//  User.swift
//  CampusImpression
//
//  Created by Jackson Lu on 5/1/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import Foundation
import Firebase

//func User()->[: <#type#>]{
//    var emptyDict: [:]
//    private(set) var username : String!
//    private(set) var birthday : String!
//    private(set) var gender : String!
//    private(set) var course : [String]!
//    private(set) var hometown : String!
//    private(set) var major : String!
//    private(set) var uid : String!
//    private(set) var email: String!
//    
//    var course_ref: DocumentReference!
//    
//    func user_data(){
//        guard let userid = Auth.auth().currentUser?.uid else {return}
//        guard let email  = Auth.auth().currentUser?.email else {return}
//        course_ref = Firestore.firestore().collection("users").document(userid)
//        course_ref.getDocument { (data, error) in
//            if let err = error {
//                debugPrint("Error fetching course:\(err)")
//            }else {
//                self.course = data?.get("course") as! [String]
//                self.birthday = data?.get("birthday") as! String
//                self.username = data?.get("username") as! String
//                self.gender = data?.get("gender") as! String
//                self.hometown = data?.get("hometown") as! String
//                self.major = data?.get("major") as! String
//                self.uid = userid
//                self.email = email
//            }
//        }
//    }
//    
//    init(username: String, birthday: String, gender : String, course: [String], hometown: String, major: String, uid: String,email: String){
//        user_data()
//        self.username = username
//        self.birthday = birthday
//        self.gender = gender
//        self.hometown = hometown
//        self.major = major
//        self.course = course
//        self.uid = uid
//        self.email = email
//        
//    }
//    
//
//}
