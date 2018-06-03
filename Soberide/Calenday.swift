//
//  Calenday.swift
//  Soberide
//
//  Created by Grant Parton on 6/1/18.
//  Copyright © 2018 Grant Parton. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Calenday : NSObject {
    
    var day: String
    var contact: String
    var driver: String
    let ref: DatabaseReference?
    
    //Initializer for GeoFire setup
    init(snapshot: DataSnapshot) {
        
        let snaptemp = snapshot.value as! [String : AnyObject]
        
        self.day = snaptemp["day"] as? String ?? "N/A"
        self.contact = snaptemp["contact"] as? String ?? "N/A"
        self.driver = snaptemp["driver"] as? String ?? "N/A"
        ref = snapshot.ref
        
        super.init()
    }
}

