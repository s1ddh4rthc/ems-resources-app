//
//  AdminRegistrationViewController.swift
//  EMS Resources App
//
//  Created by Siddharth on 1/29/22.
//

import Foundation
import Firebase
import UIKit

class AdminRegistrationViewController: UIViewController {
    
    // replace with actual UI Fields
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pswdTextField: UITextField!
    @IBOutlet weak var confirmPswdTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.resignFirstResponder()
        pswdTextField.resignFirstResponder()
        confirmPswdTextField.resignFirstResponder()
    }
    
    
    @IBAction func registerPressed(_ sender: Any) {
        
        if let email = emailTextField.text {
            if let pswd = pswdTextField.text {
                if let confirmPswd = confirmPswdTextField.text {
                    if (pswd == confirmPswd) {
                        Auth.auth().createUser(withEmail: email, password: pswd) { (result, error) in
                            
                            if (error != nil) {
                                print(error!.localizedDescription)
                            } else {
                                print("User succesfully created")
                                
                                // add code to add to realtime db
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
}
