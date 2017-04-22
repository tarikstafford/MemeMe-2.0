//
//  ViewController.swift
//  MemeMe
//
//  Created by Tarik Stafford on 3/1/17.
//  Copyright © 2017 Udacity Tarik. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var memeEdit: Meme?
    
    // Save Meme to Array
    @IBAction func saveMeme(_ sender: Any) {
        save()
        saveButton.isEnabled = false
    }
    
    // Text Fields
    @IBOutlet weak var textMeme1: UITextField!
    @IBOutlet weak var textMeme2: UITextField!
    
    // Activity Controller
    @IBAction func shareToggle(_ sender: Any) {
        
        let image = save().memeImage
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        self.present(controller, animated: true, completion: nil)
        
    }
    
    //Reset all fields
    @IBAction func cancelButton(_ sender: Any) {
        imageView.image = nil
        textMeme1.text = "TOP"
        textMeme2.text = "BOTTOM"
    }

    // Properties
    let memeTextFieldDelegate = MemeTextFieldDelegate()

    // Life Cycle 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIImagePickerController .isSourceTypeAvailable(.camera){
            cameraButton.isEnabled = true
        } else {
            cameraButton.isEnabled = false
        }
        
        if imageView.image == nil {
            shareButton.isEnabled = false
            saveButton.isEnabled = false
        }
        
        textMeme1.delegate = memeTextFieldDelegate
        textMeme2.delegate = memeTextFieldDelegate
        
        textAtts(textField: textMeme1, defaultText: "TOP")
        textAtts(textField: textMeme2, defaultText: "BOTTOM")
        
        self.view.backgroundColor = UIColor.gray
    }
    
    // Text Function
    func textAtts(textField: UITextField, defaultText: String){
        let memeTextAttributes:[String:Any] = [
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -5.0]
        
        textField.defaultTextAttributes = memeTextAttributes
        textField.text = defaultText
        textField.textAlignment = NSTextAlignment.center

    }

    
    // Gallery Button
    @IBAction func galleryToggle(_ sender: Any) {
        
        presentImagePicker(source: .photoLibrary)
    }
    
    // Camera Button
    @IBAction func cameraToggle(_ sender: Any) {
        
        if UIImagePickerController .isSourceTypeAvailable(.camera) {
            let cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.sourceType = .camera
            cameraPicker.allowsEditing = false
            cameraPicker.cameraCaptureMode = .photo
            present(cameraPicker, animated: true, completion: nil)
        }
    }
    
    // ImagePicker Func
    func presentImagePicker(source: UIImagePickerControllerSourceType) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Image Picker Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = chosenImage
        dismiss(animated: true, completion: nil)
        if imageView.image != nil {
            shareButton.isEnabled = true
            saveButton.isEnabled = true
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    //Generate The Image
    func generateMemeImage() -> UIImage {
        
        self.navBar?.isHidden = true
        self.toolBar?.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.navBar?.isHidden = false
        self.toolBar?.isHidden = false
        
        return memeImage
    }
    
    //Save the MemeObject
    func save() -> Meme {
        let meme = Meme(topTextField: textMeme1.text!, bottomTextField: textMeme2.text!, image: imageView.image!, memeImage: generateMemeImage())
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        return meme
    }
    
}

