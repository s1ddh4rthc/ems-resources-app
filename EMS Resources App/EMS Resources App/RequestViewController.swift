//
//  RequestViewController.swift
//  EMS Resources App
//
//  Created by Siddharth on 1/30/22.
//

import Foundation
import Firebase
import UIKit

class RequestViewController: UIViewController {
    
    @IBOutlet weak var emsNameField: UITextField!
    @IBOutlet weak var patientAddressField: UITextField!
    @IBOutlet weak var patientAgeField: UITextField!
    @IBOutlet weak var patientGenderField: UITextField!
    @IBOutlet weak var patientConditionsField: UITextField!
    
    // let email = "test-gmail-com"
    let email = Auth.auth().currentUser?.email?.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
    let db = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emsNameField.resignFirstResponder()
        patientAddressField.resignFirstResponder()
        patientAgeField.resignFirstResponder()
        patientGenderField.resignFirstResponder()
        patientConditionsField.resignFirstResponder()
        
    }
    
    @IBAction func sendRequest(_ sender: Any) {
        
        if let emsName = emsNameField.text {
            
            if let patientAddress = patientAddressField.text {
                
                if let patientAge = patientAgeField.text {
                    
                    if let patientGender = patientGenderField.text {
                        
                        if let patientCondition = patientConditionsField.text {
                            
                            let entry = ["emsName": emsName, "patientAddress": patientAddress, "patientAge": patientAge, "patientGender": patientGender, "patientCondition": patientCondition]
                            db.child("Outgoing-Requests").child(email!).setValue(entry)
                        }
                    }
                }
            }
        }
        
        if (emsNameField.text!.isEmpty || patientAddressField.text!.isEmpty || patientAgeField.text!.isEmpty || patientGenderField.text!.isEmpty || patientConditionsField.text!.isEmpty) {
            
            print("Some fields are incomplete.")
            
        }
        
    }

}
