//
//  ViewController.swift
//  ML_kit(Basic)
//
//  Created by Ravi Thakur on 06/10/20.
//

import UIKit
import CoreML

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let picker = UIImagePickerController()
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imagedetect: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func selectImage(_ sender: Any) {
        
        
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.present(picker, animated: true, completion: nil)
        
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let selectedimage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)
        
        if let myimage = selectedimage{
            
            imageView.image = myimage
            
            
            
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    
}

