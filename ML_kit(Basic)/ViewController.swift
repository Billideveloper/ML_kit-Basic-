//
//  ViewController.swift
//  ML_kit(Basic)
//
//  Created by Ravi Thakur on 06/10/20.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let picker = UIImagePickerController()
    
    var myModel: Resnet50 = try! Resnet50(configuration: MLModelConfiguration.init())
    
    let mymodel2 : MobileNetV2 = try! MobileNetV2(configuration: MLModelConfiguration.init())
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imagedetect: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    
      
        // Do any additional setup after loading the view.
    }

    @IBAction func selectImage(_ sender: Any) {
    
        picker.sourceType = .photoLibrary
       
        present(picker, animated: true, completion: nil)
        
    }
    
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let selectedimage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage)
        
        if let myimage = selectedimage{
            
            imageView.image = myimage
            
            picker.dismiss(animated: true, completion: nil)
        
        }
        
    }
    
    
    //MARK: - detect Image Here
    
    func detectImage(image: UIImage){
        if let mymodel = try? VNCoreMLModel(for: myModel.model){
            let myrequest = VNCoreMLRequest(model: mymodel) { [self] (request, error) in
                
                if let results = request.results as? [VNClassificationObservation]{
                    
//                    for i in results{
//
//                        let text = i.identifier
//
//                    }
                    
                    if let identity = results.first?.identifier,
                       let percent = results.first?.confidence{
                    
                    imagedetect.text = "\(String(describing: identity)) & \(String(describing: percent))"
                    }
                    
                }
                
            }
            let mimage = imageView.image!
            let cgimage = CIImage(image: mimage)
            let handler = VNImageRequestHandler(ciImage: cgimage!)
            try? handler.perform([myrequest])
            }

    }
    
    func detectImage2(image: UIImage){
        
        //define model
        
        if let mymodel2 = try? VNCoreMLModel(for: mymodel2.model){
            
            //request from model
            
            let request = VNCoreMLRequest(model: mymodel2) { (request, error) in
                
               //get results now
                
                if let results = request.results as? [VNClassificationObservation]{
                    
                    if let identity = results.first?.identifier, let percent = results.first?.confidence{
                        
                        self.label2.text = "\(String(describing: identity)) & \(String(describing: percent))"
                    }
                    
                }
                
                
                
            }
            
            //define image
            let mimage = imageView.image!
            //define cgimage
            let cgimage = CIImage(image: mimage)
            //request handler data
            let handler = VNImageRequestHandler(ciImage: cgimage!)
            //fetch request results
            try? handler.perform([request])
            
            
            
            
        }
        
    }
    

    @IBAction func fetch(_ sender: Any) {
        
        let mimage = imageView.image!
        
        detectImage2(image: mimage)
        
        //detectImage(image: mimage)
    }
    
    
    
    
    
}

