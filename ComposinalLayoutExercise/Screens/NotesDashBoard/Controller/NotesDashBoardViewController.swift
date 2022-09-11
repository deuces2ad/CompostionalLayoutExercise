//
//  ViewController.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 09/09/22.
//

import UIKit
import Combine

class NotesDashBoardViewController: UIViewController {

    //Private variables
    private let viewModel = NotesDashboardViewModel()
    private var notesItems = [NotesItemsModel]()
    private var colorIndex = -1
    private var observers : [AnyCancellable] = []
    
    //MARK: - LifeCycle methods
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        intialize()
    }
    
    lazy var rootView : NotesRootView = {
        let rootView = NotesRootView()
        return rootView
    }()
    
    private func intialize(){
        paintNavigationTitle()
        configureCollectionViewCell()
        viewModel.getNotesItems()
        registerLisntners()
    }

    private func configureCollectionViewCell(){
        self.rootView.notesCollectionView.delegate = self
        self.rootView.notesCollectionView.dataSource = self
        self.rootView.notesCollectionView.register(NotesCollectionViewCell.self, forCellWithReuseIdentifier: NotesCollectionViewCell.cellIdenttifier)
     
    }
    
    private func paintNavigationTitle(){
        self.navigationItem.title = "Notes"
        let navBarApprence = UINavigationBarAppearance()
        navBarApprence.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white]
        navBarApprence.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navBarApprence.backgroundColor = UIColor.init(hexString: "#252525")
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.standardAppearance = navBarApprence
        navigationController?.navigationBar.scrollEdgeAppearance = navBarApprence
    }
    
    private func registerLisntners(){
        //Notes info
        viewModel.listner = {[weak self] items in
            self?.notesItems = items
            self?.rootView.notesCollectionView.reloadData()
        }
        
        //Add new Note!
        rootView.action.sink {[weak self] message in
          //navigation
            
        }
        .store(in: &observers)
    }
}

extension NotesDashBoardViewController : UICollectionViewDataSource{
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
      1
    }
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notesItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotesCollectionViewCell.cellIdenttifier, for: indexPath) as? NotesCollectionViewCell{
            cell.fillInfo(with: notesItems[indexPath.row])
            cell.layer.cornerRadius = 8
            self.colorIndex += colorIndex < (AppThemeColors.stickyColors.count - 1)  ? 1 : -(AppThemeColors.stickyColors.count - 1)
            cell.backgroundColor = AppThemeColors.stickyColors[colorIndex]
            return cell
        }
        return UICollectionViewCell()
    }
}
extension NotesDashBoardViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedNoteInfo = self.notesItems[indexPath.row]
        let  vc = DetailedNoteViewController(notesInfo: selectedNoteInfo)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

