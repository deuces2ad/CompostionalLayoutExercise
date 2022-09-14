//
//  NotesCollectionViewCell.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 10/09/22.
//

import Foundation
import UIKit

class NotesCollectionViewCell : UICollectionViewCell {

    static let cellIdentifier = "NotesCollectionViewCell"
   
    //MARK: - life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutUI()
        setConstraints()
    }
    
    //MARK: - Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 3
        label.font = AppFont.noteTitleFontForCollectionViewCell
        label.textAlignment = .center
        return label
    }()
    
    private lazy var noteCreationDateLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.font = UIFont(name: "Avenir Book", size: 16)
        label.textAlignment = .right
        return label
    }()
    
    //MARK: - Methods
    func fillInfo(with info:NoteInformation) {
        self.titleLabel.text = info.noteTitle
        let date = DateParser.convertToFormatedDate(with: Int(info.noteCreationDate.timeIntervalSince1970))
        self.noteCreationDateLabel.text = date
    }
    
    private func layoutUI() {
        addSubview(titleLabel)
        addSubview(noteCreationDateLabel)
    }
    
    private func setConstraints() {
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
        noteCreationDateLabel.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 15, right: 10))
    }
}
