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
    var orgs = ["Theta Chi", "Sigma Nu", "Zeta Beta Tau", "Lambda Chi Alpha", "Ski Club", "GLO", "demo group"]
    
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
    
    //Function that loads second picker with organizations based on what is registered to the school in the DB
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//        let pos = pickerView.selectedRow(inComponent: 0);
//
//        if(pos == 0) {
//            //Update picker based on what school we're talking about
//            orgs.removeAll()
//            databaseReference = Database.database().reference(withPath: schools[0])
//            databaseReference?.queryOrdered(byChild: schools[0]).observe(.value, with:
//                { snapshot in
//                    //For every organization of this school, add it to the array.
//                    for item in snapshot.children {
//                        let org = Organization(snapshot: item as! DataSnapshot)
//                        self.orgs.append(org.organization!)
//                    }
//            })
//            orgs = orgs.sorted()
//            self.orgPicker.reloadAllComponents()
//            //place = pickerView.selectedRow(inComponent: 1)
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.schoolPicker.delegate = self
        self.orgPicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

