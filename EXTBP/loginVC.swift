//
//  ViewController.swift
//  EXTBP
//
//  Created by Darin Wilson on 10/17/16.
//  Copyright © 2016 Darin Wilson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftKeychainWrapper

class loginVC: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginSegmentedControl: UISegmentedControl!
    
    let KEY_UID = "uid"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.defaultKeychainWrapper().stringForKey(KEY_UID) {
            performSegue(withIdentifier: "profileVC", sender: nil)
        }
    }
    
    @IBAction func loginRegisterBtnPressed(_ sender: AnyObject) {
                if let email = emailTextField.text, let password = passwordTextField.text {
                    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error ) in
                if error == nil {
                    print("DAW: User Signed In")
                    self.completeSignIn(id: (user?.uid)!)
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error ) in
                if error != nil {
                        print ("DAW: User failed to authenticate with Firebase")
                } else {
                        print ("DAW: Successfully created User")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                             //self.performSegue(withIdentifier: "profileVC", sender: self)
                    }
                   
                        }
                   })
                }
            })
        }
    }
    
    func fireBaseAuth(_ credentials: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print( "DAW: Unable to authenticate user with firebase - \(error)")
            } else {
                print("DAW: Successfully authenticated user with firebase")
                if let user = user {
                    self.completeSignIn(id: user.uid) 
                    
                }
                
            }
            
        })
    }
    
    func completeSignIn(id: String) {
        let keychainResult = KeychainWrapper.defaultKeychainWrapper().setString((id), forKey: self.KEY_UID)
            print("DAW: User's credentails successfully saved to keychain \(keychainResult)")
            performSegue(withIdentifier: "profileVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is profileVC {
            
        }
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
            
                
        case 1:
            usernameTextField.isHidden = false
            emailTextField.isHidden = false
            passwordTextField.isHidden = false
            
            
            
        default:
            break;
        }
    }
    
//    let alertController = UIAlertController(title: "Oops. It's wrong", message:
//        "Enter the right the correct username or password", preferredStyle: UIAlertControllerStyle.alert)
//    alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
//    self.present(alertController, animated: true, completion: nil)
//
    
    
    
            
        }
        

    

