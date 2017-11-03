//
//  ViewController.swift
//  Meme Me
//
//  Created by Tony Buckner on 3/7/17.
//  Copyright © 2017 Tony Buckner. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate,UITextFieldDelegate {
    
    //original image
    @IBOutlet weak var imagePickerView: UIImageView!
    
    //top and bottom text fields
    @IBOutlet weak var txtTop: UITextField!
    @IBOutlet weak var txtBottom: UITextField!
    
    //navigation bars
    @IBOutlet weak var topBar: UIToolbar!
    @IBOutlet weak var bottomBar: UIToolbar!
    
    //camera button
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //apply custom text attributes
        customizeTextField(textField: txtTop, defaultText: "")
        customizeTextField(textField: txtBottom, defaultText: "")
        
    }
    
    //gets rid of keyboard after "enter" has been pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
    }
    
    //Text field custom parameter setup
    func customizeTextField(textField: UITextField, defaultText: String) {
        let memeTextAttributes:[String:Any] = [
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -5.0
        ]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.text = defaultText
        textField.delegate = self
        textField.textAlignment = .center
    }
    
    //meme object save function
    func save() {
        
        // Create the meme
        let meme = Meme(topText: txtTop.text!, bottomText: txtBottom.text!, pickedImage: imagePickerView.image!, memedImage: generateMemedImage())
        
        //add saved meme to array of created memes
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    //grenerates complete meme to prepare for save
    func generateMemedImage() -> UIImage {
        
        toolbarsVisible(onOff: true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toolbarsVisible(onOff: false)
        
        return memedImage
    }
    
    func toolbarsVisible(onOff: Bool){
        
        //toggle toolbar visibility
        topBar.isHidden = onOff
        bottomBar.isHidden = onOff
        
    }
    
    //sets up keyboard appear and hide animations
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        
        //disable camera button if there is no camera on device
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func keyboardWillShow(_ notification:Notification) {
        //checks for bottom field first
        if txtBottom.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    //--------------------------------------------------------------End keyboard functions
    
    @IBAction func pickAnImage(_ sender: Any) {
        
        presentImagePicker(.photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        
        presentImagePicker(.camera)
    }
    
    func presentImagePicker(_ sourceType: UIImagePickerControllerSourceType) {
        let controller = UIImagePickerController()
        controller.sourceType = sourceType
        //the image would not appear without this
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func shareButton(_ sender: Any) {
        
        //will save as long as image isn't nil
        if imagePickerView.image != nil {
            
            //this uncommented throws an error
            let vc = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
            
            //call save function while not savinr when share modal is cancelled
            vc.completionWithItemsHandler = {(activity, complete, items, error) -> Void in
                if complete == true{
                    self.save()
                }
            }
            
           
            
            present(vc, animated: true, completion: nil)
        } else {
            
            //throws error alert if there is no image selected
            let alert = UIAlertController(title: "Error", message: "There is no image selected", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Got It!", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //outside delegate function to send images to said place
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        //for stored image
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            //sets our object with an image
            imagePickerView.image = image
        }
        
        //for camera image
        if let image = info[UIImagePickerControllerLivePhoto] as? UIImage {
            
            //sets our object with an image
            imagePickerView.image = image
        }

        //exits once picked
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
        //this clears all fields
        txtTop.text = ""
        txtBottom.text = ""
        imagePickerView.image = nil
        
        //dismiss modal presentation
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

