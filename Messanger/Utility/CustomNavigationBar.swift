//
//  CustomNavigationBar.swift
//  Messanger
//
//  Created by PHN MAC 1 on 24/05/24.
//

import UIKit

class CustomNavigationBar: UINavigationBar {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Iterate through all subviews to find the back button
        for view in self.subviews {
            if let backButton = view as? UIControl, let recognizers = backButton.gestureRecognizers {
                for recognizer in recognizers {
                    if recognizer is UILongPressGestureRecognizer {
                        // Remove the long press gesture recognizer
                        backButton.removeGestureRecognizer(recognizer)
                    }
                }
            }
        }
    }
}
