//
//  ViewController.swift
//  Soberide
//
//  Created by Grant Parton on 5/7/18.
//  Copyright © 2018 Grant Parton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, UITextFieldDelegate {
    
    var usersRef : DatabaseReference?
    var adminRef : DatabaseReference?
    
    //MARK: Properties
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    //MARK: TextField stuff
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    //MARK: Unwind
    @IBAction func unwindToLogin(segue: UIStoryboardSegue){
    }
    
    //MARK: Login stuff
    @IBAction func login(_ sender: UIButton) {
        print("User: " + self.usernameText.text!)
        print("Pass: " + self.passwordText.text!)
        //Check all users for match
        usersRef?.queryOrdered(byChild: "schools").observe(.value, with:
            { snapshot in
                for item in snapshot.children {
                    //newSchools.append(School(snapshot: item as! DataSnapshot))
                    let personTemp = Person(snapshot: item as! DataSnapshot)
                    let name = personTemp.name
                    let pass = personTemp.password
                    if(self.usernameText.text == name && self.passwordText.text == pass) {
                        print("This person is in the user DB, granting access")
                        //self.performSegue(withIdentifier: "userView", sender: sender)
                        self.performSegue(withIdentifier: "userView", sender: sender)
                    }
                }
        })
        
        adminRef?.queryOrdered(byChild: "schools").observe(.value, with:
            { snapshot in
                for item in snapshot.children {
                    print("checking a snapshot for admins")
                    let personTemp = Person(snapshot: item as! DataSnapshot)
                    let name = personTemp.name
                    let pass = personTemp.password
                    if(self.usernameText.text == name && self.passwordText.text == pass) {
                        print("This person is in the admin DB, granting access")
                        self.performSegue(withIdentifier: "adminView", sender: sender)
                    }
                }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersRef = Database.database().reference().child("users")
        adminRef = Database.database().reference().child("admins")
        self.usernameText.delegate = self
        self.passwordText.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Segue population
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "registerUserView" {
            let destVC = segue.destination as? RegisterUserView
            destVC?.username = usernameText.text
            destVC?.password = passwordText.text
        } else if segue.identifier == "registerGroupView" {
            let destVC = segue.destination as? RegisterGroupView
            destVC?.username = usernameText.text
            destVC?.password = passwordText.text
        } else if segue.identifier == "userView" {
            let destVC = segue.destination as? UserView
            destVC?.nameOfUser = usernameText.text
        }
    }
}

