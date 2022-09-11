//
//  NotesRootView.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 11/09/22.
//

import Foundation
import UIKit
import Combine

class NotesRootView: UIView {
    
    //MARK: - View life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .black
        layoutUI()
        setConstraints()
    }
    
    //MARK: - Properties
    var action = PassthroughSubject<Void,Never>()
    
    private lazy var createNewNoteBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.titleLabel?.font = .systemFont(ofSize: 28)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("+", for: .normal)
        btn.layer.cornerRadius = 35
        btn.backgroundColor = .gray.withAlphaComponent(0.8)
        btn.addTarget(self, action: #selector(didTapOnCreateBtn), for: .touchUpInside)
        return btn
    }()
    
     lazy var notesCollectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: LayoutBuilder.createCompostionalLayout())
        cv.backgroundColor = UIColor.init(hexString: "#252525")
        return cv
    }()
    
    //MARK: - Actions
    @objc func didTapOnCreateBtn(){
        action.send()
    }
    
    //MARK: - Methods
    private func layoutUI(){
        addSubview(notesCollectionView)
        notesCollectionView.addSubview(createNewNoteBtn)
    }
    
    private func setConstraints(){
        notesCollectionView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        createNewNoteBtn.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 20, right: 20),size: .init(width: 70, height: 70))
    }
}
