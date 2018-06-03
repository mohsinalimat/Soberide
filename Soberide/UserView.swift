//
//  UserView.swift
//  Soberide
//
//  Created by Grant Parton on 5/25/18.
//  Copyright © 2018 Grant Parton. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class UserView: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var databaseReference : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseReference = Database.database().reference(withPath: "calendar")
        
        //Load the view with the driver infomation
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        let str = formatter.string(from: Date())
        var day = "1"
        
        //Check calendar for match
        databaseReference?.queryOrdered(byChild: "calendar").observe(.value, with:
            { snapshot in
                for item in snapshot.children {
                    print("checking a snapshot for users")
                    let calTemp = Calenday(snapshot: item as! DataSnapshot)
                    if(calTemp.day == day) {
                        self.nameLabel.text = calTemp.driver
                        self.phoneLabel.text = calTemp.contact
                    }
                }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
