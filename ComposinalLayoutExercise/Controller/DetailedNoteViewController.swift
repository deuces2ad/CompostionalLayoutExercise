//
//  DetailedNoteViewController.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 11/09/22.
//

import Foundation
import UIKit

class DetailedNoteViewController : UIViewController {
    
    //MARK: - Private Variables
    private var noteInfo : NotesItemModel?
    
    //MARK: - Life Cycle Methods
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    //MARK: - Initialiser Method
    init(notesInfo: NotesItemModel) {
        self.noteInfo = notesInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Properties
    lazy var rootView : DetailedNoteRootView = {
        let rootView = DetailedNoteRootView()
        rootView.backgroundColor = .black
        rootView.fillInfo(with: noteInfo!)
        return rootView
    }()
}
