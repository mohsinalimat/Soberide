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
            "name" : username!,
            "password" : password,
            "school" : schools[schoolIndex],
            "organization" : orgs[orgIndex]
        ]
        userRef.setValue(base)
        
        performSegue(withIdentifier: "unwindToLoginFromUser", sender: self)
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

