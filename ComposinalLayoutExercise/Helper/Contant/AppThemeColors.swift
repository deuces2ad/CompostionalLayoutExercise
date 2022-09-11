//
//  AppThemeColors.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 11/09/22.
//

import Foundation
import UIKit


class AppThemeColors {
    
    static var stickyColors : [UIColor] {
        return notesColors.map{ color in
            UIColor.init(hexString: color)
        }
    }
    
}

let notesColors = ["#F2AB90","#F2CD7F","#E5F09B","#CF91D9","#E88EB1","#81DEEA","#81CCC4"]
