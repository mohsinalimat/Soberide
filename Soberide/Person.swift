//
//  Person.swift
//  Soberide
//
//  Created by Grant Parton on 6/1/18.
//  Copyright © 2018 Grant Parton. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Person : NSObject{
    
    var name: String
    var organization: String
    var password: String
    var school: String
    let ref: DatabaseReference?
    
    //Initializer for GeoFire setup
    init(snapshot: DataSnapshot) {
        
        let snaptemp = snapshot.value as! [String : AnyObject]
        
        self.name = snaptemp["name"] as? String ?? "N/A"
        self.organization = snaptemp["organization"] as? String ?? "N/A"
        self.password = snaptemp["password"] as? String ?? "N/A"
        self.school = snaptemp["school"] as? String ?? "N/A"
        ref = snapshot.ref
        
        super.init()
    }
}
