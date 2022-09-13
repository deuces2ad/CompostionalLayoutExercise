//
//  AppThemeColor.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 11/09/22.
//

import UIKit

enum AppThemeColor  {
    
    case orangeColor
    case yellowColor
    case greenColor
    case pinkColor
    case maroonColor
    case blueColor
    case darkGreenColor
    case themeBlackColor
    case buttonShadowColor
    
    static func notesBackgroundColors() -> [UIColor]{
        return [AppThemeColor.orangeColor.value,
                AppThemeColor.yellowColor.value,
                AppThemeColor.greenColor.value,
                AppThemeColor.pinkColor.value,
                AppThemeColor.maroonColor.value,
                AppThemeColor.blueColor.value,
                AppThemeColor.darkGreenColor.value]
    }
}

extension AppThemeColor {
    var value : UIColor {
        switch self {
        case .orangeColor:
            return UIColor(red: 242/255, green: 171/255, blue: 144/255, alpha: 1)

        case .yellowColor:
            return UIColor(red: 242/255, green: 205/255, blue: 127/255, alpha: 1)
            
        case .greenColor:
            return UIColor(red: 229/255, green: 240/255, blue: 155/255, alpha: 1)
            
        case .pinkColor:
            return UIColor(red: 207/255, green: 145/255, blue: 217/255, alpha: 1)
            
        case .maroonColor:
            return UIColor(red: 232/255, green: 142/255, blue: 177/255, alpha: 1)
            
        case .blueColor:
            return UIColor(red: 129/255, green: 222/255, blue: 234/255, alpha: 1)
            
        case .darkGreenColor:
            return UIColor(red: 129/255, green: 204/255, blue: 196/255, alpha: 1)
            
        case .themeBlackColor:
            return UIColor(red: 37/255, green: 37/255, blue: 37/255, alpha: 1)
        case .buttonShadowColor:
            return .lightGray.withAlphaComponent(0.3)
        }
    }
}
