//
//  LoginTextField.swift
//  LMS
//
//  Created by PHN MAC 1 on 05/01/24.
//

import UIKit

class PasswordTextField: UITextField{
    
 private var isPasswordMode: Bool = true
 private var eyeIconView: UIImageView =  UIImageView()
    
// MARK: - Default Fuctions
    override init(frame: CGRect) {
        super.init(frame: frame)
        setPasswordConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setPasswordConfiguration()
    }
    
    func setPasswordConfiguration() {
        isSecureTextEntry = isPasswordMode
        
        // Container view for right padding
        let paddingContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: self.frame.height))
        
        // Configure right view for password visibility toggle
        eyeIconView = UIImageView(image: UIImage(systemName: "eye.slash"))
        eyeIconView.tintColor = UIColor.systemGray3
        eyeIconView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(passwordHideShow))
        eyeIconView.addGestureRecognizer(tapGesture)
        
        // Set initial frame for eye icon
        eyeIconView.frame = CGRect(x: 0, y: 0, width: 28, height: 22)
        eyeIconView.contentMode = .scaleToFill
        eyeIconView.center = paddingContainerView.center
        // Add the eye icon to the container view
        paddingContainerView.addSubview(eyeIconView)
        
        rightView = paddingContainerView
        rightViewMode = .always
    }
    @objc private func passwordHideShow(){
        isPasswordMode.toggle()
        isSecureTextEntry = isPasswordMode
        let eyeIconName = isPasswordMode ? "eye.slash" : "eye"
        eyeIconView.image = UIImage(systemName: eyeIconName)
    }
}

// MARK: - UITextField Delegate Methods
extension PasswordTextField: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss the keyboard when return key is tapped
        textField.resignFirstResponder()
        return true
    }
}
