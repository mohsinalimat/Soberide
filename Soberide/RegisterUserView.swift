//
//  RegisterUserView.swift
//  Soberide
//
//  Created by Grant Parton on 5/28/18.
//  Copyright © 2018 Grant Parton. All rights reserved.
//


import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class RegisterUserView: UIViewController {
    //Passed in user/pass from signin screen.
    var username : String?
    var password : String?
    
    //MARK: Database Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        //        for school in schools {
        //            let schoolRef = self.databaseReference.child(school)
        //            let base = [
        //                "base": "N/A"
        //            ]
        //            schoolRef.setValue(base)
        //        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

