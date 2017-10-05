//
//  Employee.swift
//  EDirectory
//
//  Created by Kartheek chintalapati on 29/09/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class Employee: NSObject {
    
    var gender:String!
    var name:[String:AnyObject]!
    var location:[String:AnyObject]!
    var email:String!
    var dob:String!
    var phone:String!
    var cell:String!
    var largePic:String!
    var thumbnailPic:String!
    var nat:String!
    
    init(gender:String!, name:[String:AnyObject]!, location:[String:AnyObject]!, email:String!, dob:String!, phone:String!, cell:String!, thumbnailPic:String!, largePic:String!, nat:String!) {
        self.gender = gender
        self.name = name
        self.largePic = largePic
        self.location = location
        self.email = email
        self.dob = dob
        self.phone = phone
        self.cell = cell
        self.thumbnailPic = thumbnailPic
        self.nat = nat
    }
}
