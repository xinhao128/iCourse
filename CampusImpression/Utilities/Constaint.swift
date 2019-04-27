//
//  Constaint.swift
//  CampusImpression
//
//  Created by Jackson Lu on 4/26/19.
//  Copyright © 2019 Xinhao Liang. All rights reserved.
//

import Foundation
import Firebase


// variable
let USERS_REF = "users"

let USERNAME = "username"
let DATE_CREATED = "dateCreated"
let GENDER = "gender"
let HOMETOWN = "hometown"
let MAJOR = "major"
let BIRTHDAY = "birthday"


// function
func list_of_value(lm: [QueryDocumentSnapshot],key: String) -> [String]{
    
    var result = [String]()
    for document in lm {
        result.append((document.data())[key] as! String )
    }
    return result
}
