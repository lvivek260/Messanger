//
//  SignupVC.swift
//  Messanger
//
//  Created by PHN MAC 1 on 20/05/24.
//

import UIKit
import FirebaseAuth

class SignupVC: UIViewController{
//MARK: - IBOutlets
    @IBOutlet weak var profileImg: ImagePickerImageView!

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: PasswordTextField!
    
//MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImg.viewController = self
        profileImg.imageSelectHander = { image in
            
        }
    }
    
//MARK: - IBActions
    @IBAction func didSignUpBtnClick(_ sender: ActivityButton) {
        guard let email = txtEmail.text, let password = txtPassword.text else { return }
        sender.isLoading = true
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) {[weak self] result, error in
            if let result, error == nil{
                sender.isLoading = false
                self?.showAlertMessage(title: "Success", message: "SignUp successfully complete."){
                    self?.navigationController?.popViewController(animated: true)
                }
            }else{
                sender.isLoading = false
                self?.showAlertMessage(title: "Failed", message: "Please try again")
            }
        }
    }
    
}

