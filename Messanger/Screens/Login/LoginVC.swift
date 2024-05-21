//
//  ViewController.swift
//  Messanger
//
//  Created by PHN MAC 1 on 20/05/24.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: PasswordTextField!
    @IBOutlet weak var lblFooter: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configFooterLbl()
    }

    @IBAction func didSignInBtnClick(_ sender: Any) {
        if let window = self.getWindow(){
            guard let email = txtEmail.text, email != "", let password = txtPassword.text, password != "" else {
                showAlertMessage(title: "Error", message: "Please enter email and password")
                return
            }
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let result, error == nil{
                    print(result)
                    window.rootViewController = AppStoryboard.main.getViewController(TabBarController.self)
                    window.makeKeyAndVisible()
                }else{
                    self.showAlertMessage(title: "Error", message: "Please enter email and password")
                }
            }
        }
    }
    
    
    func configFooterLbl(){
        let textstr = "Don’t have an acount? Sign Up here"
        lblFooter.text = textstr
        let colorAttriString = NSMutableAttributedString(string: textstr)
        let emailRange = (textstr as NSString).range(of: "Sign Up here")
        colorAttriString.addAttribute(.foregroundColor, value: UIColor.lightGreen, range: emailRange)
        lblFooter.attributedText = colorAttriString
       
        //add gesture Recognizer sentence
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(self.signUpBtnClick(gesture:)))
        lblFooter.isUserInteractionEnabled = true
        lblFooter.addGestureRecognizer(tapAction)
    }
    
    @objc private func signUpBtnClick(gesture: UITapGestureRecognizer){
        let sentenceRange = ((lblFooter.text ?? "") as NSString).range(of: "Sign Up here")
        if gesture.didTapAttributedTextInLabel(label: lblFooter, inRange: sentenceRange) {
            let signUpVC = AppStoryboard.login.getViewController(SignupVC.self)
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }
        
    }
}

