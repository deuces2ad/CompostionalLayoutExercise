//
//  UIVIew + Constraints.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 10/09/22.
//

import Foundation
import UIKit

extension UIView {
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        }
        return self.topAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.leftAnchor
        }
        return self.leftAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.rightAnchor
        }
        return self.rightAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        }
        return self.bottomAnchor
    }
    
    func anchor(top:NSLayoutYAxisAnchor?,
                leading:NSLayoutXAxisAnchor?,
                bottom:NSLayoutYAxisAnchor?,
                trailing:NSLayoutXAxisAnchor?,
                padding:UIEdgeInsets = .zero,
                size:CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top,constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading,constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing,constant: -padding.right).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom,constant: -padding.bottom).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func getFixHeightAnchor(of view: UIView, height: CGFloat) -> NSLayoutConstraint {
        let heightAnchor = view.heightAnchor.constraint(equalToConstant: height)
        NSLayoutConstraint.activate([
            heightAnchor
        ])
        return heightAnchor
    }
    
    func centerX(inView view : UIView, offset: CGSize = .zero) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset.width).isActive = true
    }
    
    func centerY(inView view : UIView, offset: CGSize = .zero) {
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset.height).isActive = true
    }
    
    func centerXY(inView view : UIView, offset: CGSize = .zero) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset.width).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset.height).isActive = true
    }
    
    func heightEqualToView(_ view : UIView, multiplier: CGFloat) {
        heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier).isActive = true
    }
    
    func widthEqualToView(_ view : UIView, multiplier: CGFloat) {
        widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier).isActive = true
    }
}
