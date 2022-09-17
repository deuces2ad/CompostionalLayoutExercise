//
//  UIViewController + Extension.swift
//  CompostionalLayoutExercise
//
//  Created by Abhishek Dhiman on 17/09/22.
//

import UIKit

extension UIViewController {
    
    func triggerLifecycleIfNeeded() {
        guard !isViewLoaded else { return }
        
        loadViewIfNeeded()
        beginAppearanceTransition(true, animated: false)
        endAppearanceTransition()
    }
}
