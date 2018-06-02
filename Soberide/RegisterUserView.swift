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

class RegisterUserView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var schoolPicker: UIPickerView!
    @IBOutlet weak var orgPicker: UIPickerView!
    
    var databaseReference : DatabaseReference!
    let schools = ["Cal Poly SLO", "Cal Poly Ponomoa", "UCSB", "UCI", "UCLA", "USC"]
    let orgs = ["Theta Chi", "Sigma Nu", "Zeta Beta Tau", "Lambda Chi Alpha", "Ski Club", "GLO"]
    //Passed in user/pass from signin screen.
    var username : String?
    var password : String?
    
    //Add user to DB
    @IBAction func registerUser(_ sender: UIButton) {
        let schoolIndex = schoolPicker.selectedRow(inComponent: 0)
        let orgIndex = orgPicker.selectedRow(inComponent: 0)
        databaseReference = Database.database().reference(withPath: "users")
        print("Gonna add " + username! + " to the user DB")
        let userRef = self.databaseReference.child(username!)
        let base = [
            "password" : password,
            "school" : schools[schoolIndex],
            "organization" : orgs[orgIndex]
        ]
        userRef.setValue(base)
        
        // create the alert
        let alert = UIAlertController(title: "Success", message: "You have successfully registered as a user of " + orgs[orgIndex] + ". Return to the login screen to access your driver.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == schoolPicker) {
            return schools.count
        } else if(pickerView == orgPicker) {
            return orgs.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == schoolPicker) {
            return schools[row]
        } else if(pickerView == orgPicker) {
            return orgs[row]
        }
        return "N/A"
    }
    
    
    //MARK: Database Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        self.schoolPicker.delegate = self
        self.orgPicker.delegate = self
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

