//
//  ImagePickerImageView.swift
//  Messanger
//
//  Created by PHN MAC 1 on 23/05/24.
//

import UIKit
import PhotosUI

class ImagePickerImageView: UIImageView {

    var viewController: UIViewController?
    var imageSelectHander: ((_ image: UIImage)->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    // Required initializer for loading from a storyboard or XIB file
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewClicked))
        tap.numberOfTapsRequired = 1
        addGestureRecognizer(tap)
    }
    
    
    @objc private func imageViewClicked(){
        let alertController = UIAlertController(title: "Select your profile photo", message: "Customize your profile picture", preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default){_ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .camera
                self.viewController?.present(imagePicker, animated: true, completion: nil)
            } else {
                self.viewController?.showAlertMessage(title: "Camera Not Available", message: "Sorry, camera is not available on this device.")
            }
        }
        
        let gallery = UIAlertAction(title: "Photos", style: .default){_ in
            var config = PHPickerConfiguration()
            config.selectionLimit = 1
            let pickerVC = PHPickerViewController(configuration: config)
            pickerVC.delegate = self
            self.viewController?.present(pickerVC, animated: true)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(camera)
        alertController.addAction(gallery)
        alertController.addAction(cancel)
        
        self.viewController?.present(alertController, animated: true)
    }

}


extension ImagePickerImageView: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    // UIImagePickerControllerDelegate method to handle when the user selects an image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Handle the selected image here
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            DispatchQueue.main.async {
                self.image = pickedImage
                self.imageSelectHander?(pickedImage)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Function to handle when the user cancels the image picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ImagePickerImageView: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let firstImageData = results.first
        firstImageData?.itemProvider.loadObject(ofClass: UIImage.self){ image, error in
            DispatchQueue.main.async {
                if let image = image as? UIImage{
                    self.image = image
                    self.imageSelectHander?(image)
                }
            }
        }
        self.viewController?.dismiss(animated: true)
    }
}
