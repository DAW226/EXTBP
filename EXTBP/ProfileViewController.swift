//
//  ProfileViewController.swift
//  EXTBP
//
//  Created by Darin Wilson on 10/18/16.
//  Copyright © 2016 Darin Wilson. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var profileTextView: UITextView!
    @IBOutlet weak var subHistoryTextView: UITextView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func makeSubmission(_ sender: AnyObject) {
    
    }
    @IBAction func profSubSwtch(_ sender: UISegmentedControl) {
        switch profileSegmentedControl.selectedSegmentIndex {
        case 0:
            profileTextView.isHidden = true
            subHistoryTextView.isHidden = false
        case 1:
            profileTextView.isHidden = false
            subHistoryTextView.isHidden = true
        default:
            break;
        }
    }

  
}
