//
//  LoginViewController.swift
//  EMS Resources App
//
//  Created by Siddharth on 1/30/22.
//

import Foundation
import Firebase
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pswdTextField: UITextField!
    
    @IBAction func loginPressed(_ sender: Any) {
        
        if let email = emailTextField.text {
            if let pswd = pswdTextField.text {
                Auth.auth().signIn(withEmail: email, password: pswd, completion: { result, error in
                    
                    if (error != nil) {
                        print(error?.localizedDescription)
                    } else {
                        print("user signed in")
                    }
                    
                })
            }
        }
        
        
        
        
    }
    
    
    
}

