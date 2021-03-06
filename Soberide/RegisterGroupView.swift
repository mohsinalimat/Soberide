//
//  RegisterView.swift
//  Soberide
//
//  Created by Grant Parton on 5/25/18.
//  Copyright © 2018 Grant Parton. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class RegisterGroupView: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var organizationName: UITextField!
    
    //Passed in user/pass from signin screen.
    var username : String?
    var password : String?
    
    var databaseReference : DatabaseReference!
    var schoolReference : DatabaseReference!
    let schools = ["Cal Poly SLO", "Cal Poly Ponomoa", "UCSB", "UCI", "UCLA", "USC"]
    
    //Adds organization to the corresponding school.
    @IBAction func finishRegistration(_ sender: UIButton) {
        //Pull the school & organization name from the UI components
        let schoolIndex = pickerView.selectedRow(inComponent: 0);
        let orgName = organizationName.text!
        
        //Create references to create admin DB entry, and to the organizations per school DB.
        databaseReference = Database.database().reference(withPath: "admins")
        schoolReference = Database.database().reference(withPath: schools[schoolIndex])
        let adminRef = self.databaseReference.child(username!)
        let schoolRef = self.schoolReference.child(orgName)
        let adminBase = [
            "name" : username!,
            "password" : password,
            "school" : schools[schoolIndex],
            "organization" : orgName
        ]
        
        //Set values in DB
        adminRef.setValue(adminBase)
        schoolRef.setValue(orgName)
        
        //Return to login screen
        performSegue(withIdentifier: "unwindSegueToLogin", sender: self)
    }
    
    //MARK: TextField stuff
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    //MARK: Picker Setup
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return schools.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return schools[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        _ = schools[row] as String
    }
    
    //MARK: Database Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        organizationName.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
