//
//  profileVC.swift
//  EXTBP
//
//  Created by Darin Wilson on 11/3/16.
//  Copyright © 2016 Darin Wilson. All rights reserved.
//

import UIKit
import MessageUI

class profileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

//    @IBOutlet weak var profileSubSegmentedControl: UISegmentedControl!
    
//    @IBOutlet weak var subHistoryTextView: UITextView!
    @IBOutlet weak var profileTextView: UITextView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var imageEdit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func imageEditPicker(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
            profileImageView.image = image
            self.dismiss(animated: true, completion: nil);
        }
        
    }
    
//    @IBAction func profileSementedControl(_ sender: AnyObject) {
//        
//        switch profileSubSegmentedControl.selectedSegmentIndex {
//            
//            case 0:
//                subHistoryTextView.isHidden = true
//                profileTextView.isHidden = false
//                profileImageView.isHidden = false
//                imageEdit.isHidden = false
//            case 1:
//                subHistoryTextView.isHidden = false
//                profileTextView.isHidden = true
//                profileImageView.isHidden = true
//                imageEdit.isHidden = true
//        default:
//            break
//        }
//
//    }
    
    @IBAction func makeSubBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "photoVC", sender: self)
    }
    

    
    
    @IBAction func logoutBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
