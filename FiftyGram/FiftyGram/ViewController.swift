//
//  ViewController.swift
//  FiftyGram
//
//  Created by ali on 12/1/20.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet var imageView: UIImageView!
    var context = CIContext()
    var originalImage: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func choosePhotoBttonDidTap(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            navigationController?.present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func sepiaFilterApply(_ sender: Any) {
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        filter?.setValue(CIImage(image: originalImage) , forKey: kCIInputImageKey)
        
        guard let outputImage = filter?.outputImage else {
            print("Filter Failed")
            return
        }
        
        imageView.image = UIImage(cgImage: self.context.createCGImage(outputImage, from: outputImage.extent)!)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            originalImage = image
        }
        
    }

}

