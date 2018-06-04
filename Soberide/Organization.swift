//
//  Organization.swift
//  
//
//  Created by Grant Parton on 6/3/18.
//

import Foundation
import FirebaseDatabase

class Organization : NSObject {
    
    var organization : String?
    var ref: DatabaseReference?
    
    //Initializer by snapshots
    init(snapshot: DataSnapshot) {
        
        organization = snapshot.value as! String!
        
        ref = snapshot.ref
        
        super.init()
    }
}
