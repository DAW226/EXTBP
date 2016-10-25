//
//  ViewController.swift
//  EXTBP
//
//  Created by Darin Wilson on 10/17/16.
//  Copyright © 2016 Darin Wilson. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerUIButton: UIButton!
    @IBOutlet weak var loginUIButton: UIButton!
   
    @IBOutlet weak var loginSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func loginRegisterSegmentedControl(_ sender: AnyObject) {
    
    
            switch loginSegmentedControl.selectedSegmentIndex {
        case 0:
            usernameTextField.isHidden = true
            emailTextField.isHidden = false
            passwordTextField.isHidden = false
            loginUIButton.isHidden = false
            registerUIButton.isHidden = true
        case 1:
            usernameTextField.isHidden = false
            emailTextField.isHidden = false
            passwordTextField.isHidden = false
            loginUIButton.isHidden = true
            registerUIButton.isHidden = false
            
        default:
            break;
        }
    }

    @IBAction func registerButton(_ sender: AnyObject) {
    
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { user, error in
            if error != nil {
        
                print("Something went wrong!")
                
            } else {
                
                let uid = ["uid"] as? String
                print("User successfully created a account!")
                
            }
        })
    }


    @IBAction func loginButton(_ sender: AnyObject) {
    
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { user, error in
            
            if error != nil {
                
                self.login()
                
            } else {
                
                print("User Created")
                self.login()
                
            }
        
        })
    }
    
    func login() {
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let _ = usernameTextField.text else {
            print("Form is not valid")
            return
        }
        
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: {(user: FIRUser?, error) in

            if error != nil {
                print(error)
                

            
            print("Incorrect")
                let alertController = UIAlertController(title: "Oops. It's wrong", message:
                    "Enter the right the correct username or password", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
                self.present(alertController, animated: true, completion: nil)
            return
            
            } else {
            
            print("User Logged in")
        
        }
            guard let uid = user?.uid else {
                return

    }
        //successfully authenticated user
        let ref = FIRDatabase.database().reference(fromURL: "https://extbp-9ca8a.firebaseio.com/")
        let usersReference = ref.child("users").child(uid)
        let values = ["name": self.usernameTextField, "email": self.emailTextField]
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err)
                return
            }
            
            print("Saved user successfully into Firebase Database")
            
            })
        
        })
    }
}
