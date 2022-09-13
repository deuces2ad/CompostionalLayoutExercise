//
//  NotesRootView.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 11/09/22.
//

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
    
    private lazy var createNewNoteButton : UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 28)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("+", for: .normal)
        button.layer.cornerRadius = 35
        button.backgroundColor = AppThemeColor.themeBlackColor.value
        button.addTarget(self, action: #selector(didTapOnCreateButton), for: .touchUpInside)
        return button
    }()
    
    lazy var notesCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: LayoutBuilder.createCompositionalLayout())
        collectionView.backgroundColor = AppThemeColor.themeBlackColor.value
        return collectionView
    }()
    
    //MARK: - Actions
    @objc func didTapOnCreateButton() {
        action.send()
    }
    
    //MARK: - Methods
    private func layoutUI() {
        addSubview(notesCollectionView)
        notesCollectionView.addSubview(createNewNoteButton)
    }
    
    private func setConstraints() {
        notesCollectionView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        createNewNoteButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 20, right: 20),size: .init(width: 70, height: 70))
    }
}
