//
//  LoginNav.swift
//  Messanger
//
//  Created by PHN MAC 1 on 20/05/24.
//

import UIKit

class LoginNav: UINavigationController {

//MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonImgConfig()
    }
    
//MARK: - Configurations Functions
    private func backButtonImgConfig(){
         // Ensure the custom back button image is set
        navigationBar.backIndicatorImage = .backIcon
        navigationBar.backIndicatorTransitionMaskImage = .backIcon
        navigationBar.tintColor = .lightGreen
        
        // Clear the back button text
        let backButtonAppearance = UIBarButtonItem.appearance()
        backButtonAppearance.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .normal)
        backButtonAppearance.setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .highlighted)
    }
    
//MARK: - Default override Methods
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        if let topViewController = self.topViewController {
            topViewController.navigationItem.backBarButtonItem = backButton
        }
        
        super.pushViewController(viewController, animated: animated)
    }
}
