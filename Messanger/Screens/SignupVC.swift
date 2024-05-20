//
//  SignupVC.swift
//  Messanger
//
//  Created by PHN MAC 1 on 20/05/24.
//

import UIKit

class SignupVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

 
    @IBAction func didSignUpBtnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        if let viewControllers = self.navigationController?.viewControllers{
            viewControllers.forEach { eachVC in
                let login = AppStoryboard.login.getViewController(LoginVC.self)
                if eachVC == login{
                    self.navigationController?.popToViewController(login, animated: true)
                }
            }
        }
    }
    
}
