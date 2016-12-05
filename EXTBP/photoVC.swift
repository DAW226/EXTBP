//
//  photoVC.swift
//  EXTBP
//
//  Created by Darin Wilson on 11/5/16.
//  Copyright © 2016 Darin Wilson. All rights reserved.
//

import UIKit
import MessageUI

class photoVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate  {

    @IBOutlet weak var jobImageOne: UIImageView!
    @IBOutlet weak var jobImageTwo: UIImageView!
    @IBOutlet weak var jobImageThree: UIImageView!
    @IBOutlet weak var jobImageFour: UIImageView!
    @IBOutlet weak var jobImageFive: UIImageView!
    @IBOutlet weak var jobImageSix: UIImageView!
   
    @IBOutlet weak var jobDescription: UITextField!
    
    @IBOutlet weak var emailPhotoBtn: UIButton!
    @IBOutlet var emailPhotoBtns: [UIButton]!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var CurrentSelectedImage = 0
    
    //DCS:  We really only need one image picker
    let imagePicker = UIImagePickerController()
    
    //DCS:  Here we  declare an array to hold all of our image views for easy use later in the app
    var JobImages: [UIImageView] = [UIImageView]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    // DCS:  we only need to call these statments once for our view controller, because we eliminted our switch statement below

        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
        imagePicker.allowsEditing = false
        
    //DCS:  Add all of our image views to the array
        
        JobImages.append(jobImageOne)
        JobImages.append(jobImageTwo)
        JobImages.append(jobImageThree)
        JobImages.append(jobImageFour)
        JobImages.append(jobImageFive)
        JobImages.append(jobImageSix)
    
    }
    
    //DCS: This will be called after we have selected our image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Finished Picking Image")
        
        //insert
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //print(info)
            //let imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
            JobImages[CurrentSelectedImage].contentMode = .scaleToFill
            JobImages[CurrentSelectedImage].image = pickedImage
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func photoBtnPressedOne(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            
            guard let button = sender as? UIButton else {
                return
            }
            
            //DCS: Set the currently selected image
            CurrentSelectedImage = button.tag - 1
            
            //DCS:  show our image picker
            present(imagePicker, animated: true, completion: {
            })
        }
    }
    
    
    @IBAction func emailPhotoBtnPressed(_ sender: AnyObject) {
        let emailPhotos = MFMailComposeViewController()
        emailPhotos.mailComposeDelegate = self
        emailPhotos.setToRecipients(["darin.wilson226@gmail.com"])
        emailPhotos.setSubject("Sent by --- job \(jobDescription.text)")
        emailPhotos.setMessageBody("", isHTML: true)
        
    //Checking if the device can send mail
        if( MFMailComposeViewController.canSendMail() ) {
            print("DAW: Can send email.")
            
        }
        
        for i in 0...JobImages.count {
            if let image = JobImages[i].image {
                let data: Data = UIImageJPEGRepresentation(image, 1.0)!
                emailPhotos.addAttachmentData(data, mimeType: "image/jpeg", fileName: "Job\(i)image")
            }
            
            func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: Error!) {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
    
    present(emailPhotos, animated: true, completion: nil)
    
    }
    @IBAction func cancelBtnPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)

    

    }
}

