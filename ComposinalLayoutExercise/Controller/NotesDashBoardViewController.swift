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
    private let notesDashboardViewModel = NotesDashboardViewModel()
    private var notesItems = [NotesItemModel]()
    private var colorIndex = -1
    private let navigationTitle = "Notes"
    private var observers : [AnyCancellable] = []
    private var manager = NoteManager()
    
    //MARK: - LifeCycle methods
    override func loadView() {
        super.loadView()
        view = rootView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    lazy var rootView : NotesRootView = {
        let rootView = NotesRootView()
        return rootView
    }()
    
    private func initialSetup() {
        updateNavBarAppearance()
        configureCollectionViewCell()
        notesDashboardViewModel.getNotesItems()
        registerListeners()
    }

    //MARK: - Methods
    private func configureCollectionViewCell() {
        self.rootView.notesCollectionView.delegate = self
        self.rootView.notesCollectionView.dataSource = self
        self.rootView.notesCollectionView.register(NotesCollectionViewCell.self, forCellWithReuseIdentifier: NotesCollectionViewCell.cellIdentifier)
    }
    
    private func registerListeners(){
    
        notesDashboardViewModel.$listener
            .sink { items in
                let offlineNotes = self.notesDashboardViewModel.createNoteModelFromNotesInformation(with: self.manager.fetchNote()!)
                self.notesItems = items
                self.notesItems.append(contentsOf: offlineNotes)
               
                self.rootView.notesCollectionView.reloadData()
            }.store(in: &observers)
        
        //Add new Note!
        rootView.action.sink {[weak self] message in
          //navigation
            guard let self = self else {return}
            
            let addNewNotesViewController = AddNewNoteViewController()
            addNewNotesViewController
                .$newNoteListener
                .compactMap{$0}
                .map{self.notesDashboardViewModel.createNewModelInfo(with: $0)}
                .sink { item in
                self.notesItems.append(item)
                self.rootView.notesCollectionView.reloadData()
            }.store(in: &self.observers)
            self.navigationController?.pushViewController(addNewNotesViewController, animated: true)
        }
        .store(in: &observers)
    }
    
     private func updateNavBarAppearance(){
        self.navigationItem.title = navigationTitle
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
         navBarAppearance.backgroundColor = AppThemeColor.themeBlackColor.value
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

extension NotesDashBoardViewController : UICollectionViewDataSource {
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
      1
    }
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notesItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotesCollectionViewCell.cellIdentifier, for: indexPath) as? NotesCollectionViewCell{
            cell.fillInfo(with: notesItems[indexPath.row])
            cell.layer.cornerRadius = 8
            self.colorIndex += colorIndex < (AppThemeColor.notesBackgroundColors().count - 1)  ? 1 : -(AppThemeColor.notesBackgroundColors().count - 1)
            cell.backgroundColor = AppThemeColor.notesBackgroundColors()[colorIndex]
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

//MARK: - Data Format Helping Class

class DateParser {
    
    static func convertToFormatedDate(with timeInterval:Int) -> String{
        let date = NSDate(timeIntervalSince1970: TimeInterval(timeInterval))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = AppInfo.appDateFormat
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    }
}
