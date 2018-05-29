//
//  ViewController.swift
//  Soberide
//
//  Created by Grant Parton on 5/7/18.
//  Copyright © 2018 Grant Parton. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    //MARK: TextField stuff
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    //MARK: Registration segues
    @IBAction func registerGroup(_ sender: UIButton) {
        performSegue(withIdentifier: "registerGroupView", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameText.delegate = self
        passwordText.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Prepare to send user/pass info to any of three segues.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "registerUserView" {
            let destVC = segue.destination as? RegisterUserView
            destVC?.username = usernameText.text
            destVC?.password = passwordText.text
        } else if segue.identifier == "registerGroupView" {
            let destVC = segue.destination as? RegisterGroupView
            destVC?.username = usernameText.text
            destVC?.password = passwordText.text
        }
    }


}

