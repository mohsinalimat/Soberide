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
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .long
        let str = formatter.string(from: now)
        print(str)
        var day = "1"
        
        //Check calendar for match
        databaseReference?.queryOrdered(byChild: "calendar").observe(.value, with:
            { snapshot in
                for item in snapshot.children {
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
