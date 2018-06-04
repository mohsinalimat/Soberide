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
    var monthsArr = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var databaseReference : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load the view with the driver infomation by first pulling the month/day
        let currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
        let todaysDate = String(Calendar.current.component(.day, from: Date()))
        
        //Query calendar by month, for our day we juts pulled
        databaseReference = Database.database().reference(withPath: monthsArr[currentMonthIndex])
        databaseReference?.queryOrdered(byChild: monthsArr[currentMonthIndex]).observe(.value, with:
            { snapshot in
                for item in snapshot.children {
                    let calTemp = Calenday(snapshot: item as! DataSnapshot)
                    if(calTemp.day == todaysDate) {
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
