//
//  SceneDelegate.swift
//  Messanger
//
//  Created by PHN MAC 1 on 20/05/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = AppStoryboard.login.getViewController(LoginNav.self)
        window.makeKeyAndVisible()
        self.window = window
    }

   
}

