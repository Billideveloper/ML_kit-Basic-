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
    
    let MyLibrary = Resnet50()
    
    
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
        
        
        if let mymodel = try? VNCoreMLModel(for: MyLibrary.model){
            
            
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
    
//        //to get VNCoreML model import Vision
//        do{
//        let model = try VNCoreMLModel(for: MyLibrary.model)
//        let request = VNCoreMLRequest(model: model, completionHandler: handleResults)
//            let mimage = imageView.image!
//            let cgimage = CIImage(image: mimage)
//            let handler = VNImageRequestHandler(ciImage: cgimage!)
//            try handler.perform([request])
//
//        }catch{
//            print("error")
//        }
    }
    
    
    
//    func handleResults(request: VNRequest, error: Error?) {
//
//        guard let results = request.results as? [VNCoreMLFeatureValueObservation]
//          else {
//            print(error?.localizedDescription as Any)
//            return
//        }
//
//        print(results)
//    }

    @IBAction func fetch(_ sender: Any) {
        
        let mimage = imageView.image!
        
        detectImage(image: mimage)
    }
    
    
    
    
    
}

