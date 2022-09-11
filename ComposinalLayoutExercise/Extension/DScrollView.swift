//
//  DScrollView.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 11/09/22.
//

import Foundation
import UIKit

class DScrollView: UIScrollView {
  
  var containerView : UIView?
  
   init() {
    super.init(frame: .zero)
    
//    backgroundColor = .yellow
    let view = UIView()
//    view.backgroundColor = .red
    addSubview(view)
    
    self.containerView = view
    setupView()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView(){
    containerView?.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    containerView?.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0).isActive = true
  }
  
}
