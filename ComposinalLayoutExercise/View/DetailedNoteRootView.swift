//
//  DetailedNoteRootView.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 11/09/22.
//

import UIKit

class DetailedNoteRootView :UIView {
    
    //MARK: - View LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutUI()
        setConstraints()
    }
    //MARK: - Properties
    private var noteImageHeightAnchor = 200

    
    lazy var scrollView : CustomScrollView = {
        let scrollView = CustomScrollView()
        return scrollView
    }()
    
    private lazy var noteHeaderImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private lazy var noteTitle : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = AppFont.noteTitleFont
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var noteCreatedDateLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private lazy var noteDescriptionTxtView : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = AppFont.noteDescriptionFont
        return label
    }()
    
    
    //MARK: - Methods
    private func layoutUI() {
        addSubview(scrollView)
        scrollView.addSubview(noteHeaderImage)
        scrollView.addSubview(noteTitle)
        scrollView.addSubview(noteCreatedDateLabel)
        scrollView.addSubview(noteDescriptionTxtView)
        
    }
    
    private func setConstraints() {
        scrollView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        noteHeaderImage.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 5, left: 10, bottom: 0, right: 10),size: .init(width: 0, height: noteImageHeightAnchor))
        
        noteTitle.anchor(top: noteHeaderImage.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor,padding: .init(top: 5, left: 30, bottom: 10, right: 30))
        
        
        noteCreatedDateLabel.anchor(top: noteTitle.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor,padding: .init(top: 10, left: 30, bottom: 10, right: 30))
        
        noteDescriptionTxtView.anchor(top: noteCreatedDateLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: trailingAnchor,padding: .init(top: 10, left: 30, bottom: 10, right: 30))
    }
    
    //TODO: ReVisit this image saving logic.
    func fillInfo(with noteInfo : NoteInformation) {
        if let noteImage = noteInfo.noteImageData {
            self.noteHeaderImage.image = UIImage(data: noteImage)
        }else if let imageUrl = noteInfo.noteImage{
            let url = URL(string: imageUrl)!
            self.noteHeaderImage.loadImageFrom(url: url)
        } else {
            noteImageHeightAnchor = 0
            noteHeaderImage.layoutIfNeeded()
        }
        self.noteTitle.text = noteInfo.noteTitle
        self.noteCreatedDateLabel.text = DateParser.convertToFormatedDate(with: Int(noteInfo.noteCreationDate.timeIntervalSince1970))
        self.noteDescriptionTxtView.text = noteInfo.noteDescription
    }
}

//MARK: - ScrollView Helping Class
class CustomScrollView: UIScrollView {
  
  var containerView : UIView?
  
   init() {
    super.init(frame: .zero)
    let view = UIView()
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

//MARK: - UIImageView + Extension
extension UIImageView {
    func loadImageFrom(url: URL){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

