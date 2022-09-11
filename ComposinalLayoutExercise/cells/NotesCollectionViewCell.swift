//
//  NotesCollectionViewCell.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 10/09/22.
//

import Foundation
import UIKit

class NotesCollectionViewCell : UICollectionViewCell {

    static let cellIdenttifier = "NotesCollectionViewCell"
   
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutUI()
        setContraints()
    }
    
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 3
        lbl.font = UIFont(name: "Avenir Book", size: 22.0)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var dateLbl : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 2
        lbl.font = UIFont(name: "Avenir Book", size: 16)
        lbl.textAlignment = .right
        return lbl
    }()
    
    func fillInfo(with info:NotesItemsModel){
        self.titleLbl.text = info.title
        let date = DateParser.convertToFormatedDate(with: info.createdTime)
        self.dateLbl.text = date
    }
    
    private func layoutUI(){
        addSubview(titleLbl)
        addSubview(dateLbl)
    }
    
    private func setContraints(){
        titleLbl.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        dateLbl.anchor(top: titleLbl.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 0, bottom: 15, right: 10))
    }
}
