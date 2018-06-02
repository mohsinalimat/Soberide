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
    let schools = ["Cal Poly SLO", "Cal Poly Ponomoa", "UCSB", "UCI", "UCLA", "USC"]
    
    //Adds organization to the corresponding school.
    @IBAction func finishRegistration(_ sender: UIButton) {
        let schoolIndex = pickerView.selectedRow(inComponent: 0);
        let orgName = organizationName.text!
        //databaseReference = Database.database().reference(withPath: schools[schoolIndex])
        databaseReference = Database.database().reference(withPath: "admins")
        //print("Gonna add " + schools[schoolIndex] + ", " + orgName + " to the DB")
        print("Gonna add " + username! + " to the admin DB")
        let adminRef = self.databaseReference.child(username!)
        let base = [
            "password" : password,
            "school" : schools[schoolIndex],
            "organization" : orgName
        ]
        adminRef.setValue(base)
        
        
        
        // create the alert
        let alert = UIAlertController(title: "Success", message: "You have successfully registered your group. Return to the login screen to access your calendar.", preferredStyle: UIAlertControllerStyle.alert)

        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
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
