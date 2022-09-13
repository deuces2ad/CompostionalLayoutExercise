//
//  AddNewNoteRootView.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 11/09/22.
//

import UIKit
import Combine

class AddNewNoteRootView : UIView {
    
    //MARK: - Private variable
    private let titleViewPlaceholderText = "Title..."
    private let descriptionPlaceholderText = "Type something..."
    //MARK: - Listeners
    var imagePickerListener = PassthroughSubject<Void,Never>()
    var saveNoteListener = PassthroughSubject<Void,Never>()
    var backButtonListener = PassthroughSubject<Void,Never>()
    
    var newNoteTextViewHeightAnchor = 70.0
    
    
    //MARK: - View Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutUI()
        setConstraints()
    }
   
    lazy var newNoteTitleTextView :CustomTextView = {
        let textView = CustomTextView()
        textView.backgroundColor = AppThemeColor.themeBlackColor.value
        textView.textColor = .white.withAlphaComponent(0.8)
        textView.font = AppFont.noteTitleFont
        textView.placeholderText = titleViewPlaceholderText
        return textView
    }()
    
    lazy var newNoteDescriptionTextView :CustomTextView = {
        let textView = CustomTextView()
        textView.backgroundColor = AppThemeColor.themeBlackColor.value
        textView.textColor = .white.withAlphaComponent(0.6)
        textView.font = AppFont.noteDescriptionFont
        textView.placeholderText = descriptionPlaceholderText
        return textView
    }()
    
    private lazy var imagePickerButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: AppSFsymbols.paperclip.rawValue), for: .normal)
        button.addTarget(self, action: #selector(imagePickerAction), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = AppThemeColor.buttonShadowColor.value
        button.layer.cornerRadius = 12
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    private lazy var saveNoteButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveNoteAction), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .lightGray.withAlphaComponent(0.3)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var backButton : UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        button.tintColor = .white
        button.setImage(UIImage(systemName: AppSFsymbols.chevronBackward.rawValue), for: .normal)
        button.backgroundColor = .lightGray.withAlphaComponent(0.3)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var buttonStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imagePickerButton,saveNoteButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()
    
    //MARK: - Actions
    @objc func imagePickerAction(){
        imagePickerListener.send()
    }
    
    @objc func saveNoteAction(){
        saveNoteListener.send()
    }
    
    @objc func backAction(){
        backButtonListener.send()
    }
    
    //MARK: - Methods
    private func layoutUI(){
        let uiElements = [backButton,
                          buttonStackView,
                          newNoteTitleTextView,
                          newNoteDescriptionTextView]
        
        uiElements.forEach { element in
            addSubview(element)
        }
    }
    
    private func setConstraints(){
        
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 40, left: 30, bottom: 0, right: 0),size: .init(width: 40, height: 40))
        
        buttonStackView.anchor(top: nil, leading: nil, bottom: newNoteTitleTextView.topAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 10, right: 30))
        buttonStackView.centerY(inView: backButton)
        
        newNoteTitleTextView.anchor(top: imagePickerButton.bottomAnchor, leading: backButton.leadingAnchor, bottom: nil, trailing: buttonStackView.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 10),size: .init(width: 0, height:newNoteTextViewHeightAnchor))
       

        newNoteDescriptionTextView.anchor(top: newNoteTitleTextView.bottomAnchor, leading: newNoteTitleTextView.leadingAnchor, bottom: bottomAnchor, trailing: newNoteTitleTextView.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 10, right: 10))
        
    }
}

//MARK: - Custom TextView Helper Class

class CustomTextView : UITextView, UITextViewDelegate {
    
    var placeholderText = ""
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutUI()
        delegate = self
    }
    
    private lazy var placeholderLabel : UILabel = {
        let label = UILabel()
        label.text = placeholderText
        label.font = self.font
        label.textColor = .white.withAlphaComponent(0.5)
        label.numberOfLines = 0
        return label
    }()
    
    func layoutUI(){
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 5, left: 5, bottom: 5, right: 10))
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
}

