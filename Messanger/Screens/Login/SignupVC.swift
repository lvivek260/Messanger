//
//  SignupVC.swift
//  Messanger
//
//  Created by PHN MAC 1 on 20/05/24.
//

import UIKit
import PhotosUI
import FirebaseAuth

class SignupVC: UIViewController{
//MARK: - IBOutlets
    @IBOutlet weak var profileImg: UIImageView!{
        didSet{
            profileImg.layer.cornerRadius = 80
            profileImg.layer.borderWidth = 2
            profileImg.layer.borderColor = UIColor.secondaryLabel.cgColor
            profileImg.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(profileImgClicked))
            tap.numberOfTapsRequired = 1
            profileImg.addGestureRecognizer(tap)
        }
    }
    @objc private func profileImgClicked(){
        let alertController = UIAlertController(title: "Select your profile photo", message: "Customize your profile picture", preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default){_ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.isEditing = true
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            } else {
                self.showAlertMessage(title: "Camera Not Available", message: "Sorry, camera is not available on this device.")
            }
        }
        
        let gallery = UIAlertAction(title: "Photos", style: .default){_ in
            var config = PHPickerConfiguration()
            config.selectionLimit = 1
            let pickerVC = PHPickerViewController(configuration: config)
            pickerVC.delegate = self
            pickerVC.isEditing = true
            self.present(pickerVC, animated: true)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(camera)
        alertController.addAction(gallery)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
    }
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: PasswordTextField!
    
//MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
//MARK: - IBActions
    @IBAction func didSignUpBtnClick(_ sender: Any) {
        guard let email = txtEmail.text, let password = txtPassword.text else { return }
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
            print(result as Any)
        }
    }
    
}

extension SignupVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    // UIImagePickerControllerDelegate method to handle when the user selects an image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Handle the selected image here
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            DispatchQueue.main.async {
                self.profileImg.image = pickedImage
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Function to handle when the user cancels the image picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension SignupVC: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let firstImageData = results.first
        firstImageData?.itemProvider.loadObject(ofClass: UIImage.self){ image, error in
            DispatchQueue.main.async {
                self.profileImg.image = image as? UIImage
            }
        }
        self.dismiss(animated: true)
    }
}
