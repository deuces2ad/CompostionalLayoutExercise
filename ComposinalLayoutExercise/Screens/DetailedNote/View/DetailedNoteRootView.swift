//
//  DetailedNoteRootView.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 11/09/22.
//

import Foundation
import UIKit
import Nuke

class DetailedNoteRootView :UIView {
    
    //MARK: - View LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutUI()
        setContraints()
    }
    //MARK: - Properties
    private var noteImageHeightAnchor = 200
    
    lazy var scrollView : DScrollView = {
        let scrollView = DScrollView()
        return scrollView
    }()
    
    private lazy var noteHeaderImage : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var noteTitle : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        lbl.numberOfLines = 3
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private lazy var noteCreatedDateLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "Sep 06,2022"
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return lbl
    }()
    
    private lazy var noteDiscriptionTxtView : UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.font = UIFont(name: "Avenir Book", size: 22.0)
        return lbl
    }()
    
    
    //MARK: - Methods
    private func layoutUI(){
        addSubview(scrollView)
        scrollView.addSubview(noteHeaderImage)
        scrollView.addSubview(noteTitle)
        scrollView.addSubview(noteCreatedDateLbl)
        scrollView.addSubview(noteDiscriptionTxtView)
    }
    
    private func setContraints(){
        scrollView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        noteHeaderImage.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 5, left: 10, bottom: 0, right: 10),size: .init(width: 0, height: noteImageHeightAnchor))
        
        noteTitle.anchor(top: noteHeaderImage.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor,padding: .init(top: 5, left: 30, bottom: 10, right: 30))
        
        noteCreatedDateLbl.anchor(top: noteTitle.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor,padding: .init(top: 10, left: 30, bottom: 10, right: 30))
        
        noteDiscriptionTxtView.anchor(top: noteCreatedDateLbl.bottomAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 10, left: 30, bottom: 10, right: 30))
    }
    
    func fillInfo(with noteInfo : NotesItemsModel){
        if let imageURL = noteInfo.image {
            if let url = URL(string: imageURL){
                self.noteHeaderImage.loadImageFrom(url: url)
            }
        }else{
            noteImageHeightAnchor = 0
            layoutIfNeeded()
        }
        self.noteTitle.text = noteInfo.title
        self.noteCreatedDateLbl.text = DateParser.convertToFormatedDate(with: noteInfo.createdTime)
        self.noteDiscriptionTxtView.text = noteInfo.body
    }
}
