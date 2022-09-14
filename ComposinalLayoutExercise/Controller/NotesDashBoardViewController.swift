//
//  ViewController.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 09/09/22.
//

import UIKit

class NotesDashBoardViewController: UIViewController {

    //Private variables
    private let notesDashboardViewModel = NotesDashboardViewModel()
    private var notesItems = [NoteInformation]()
    private var colorIndex = -1
    private let navigationTitle = "Notes"
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
        registerListeners()
        setNavigationTitle()
        configureCollectionViewCell()
        notesDashboardViewModel.getNotesItems()
    }

    //MARK: - Methods
    private func configureCollectionViewCell() {
        self.rootView.notesCollectionView.delegate = self
        self.rootView.notesCollectionView.dataSource = self
        self.rootView.notesCollectionView.register(NotesCollectionViewCell.self, forCellWithReuseIdentifier: NotesCollectionViewCell.cellIdentifier)
    }
    
    private func registerListeners(){
        ///receive  Notes Items
        notesDashboardViewModel.noteItemsListener = { [weak self] items in
            guard let self = self else {return}
            self.populateNotesItems(with: items)
        }
        ///Add New Note!
        rootView.newNoteActionListener =  { [weak self]  in
            guard let self = self else {return}
            self.navigateToNewNoteViewController()
        }
    }
    
    private func populateNotesItems(with items: [NoteInformation]){
        self.notesItems = items
        DispatchQueue.main.async {
            self.rootView.notesCollectionView.reloadData()
        }
    }
    
    private func navigateToNewNoteViewController(){
        let addNewNotesViewController = NewNoteViewController()
        addNewNotesViewController.newNoteListener = {  newNote in
            self.notesItems.append(newNote)
            self.manager.createNote(note: newNote)
            DispatchQueue.main.async {
                self.rootView.notesCollectionView.reloadData()
            }
           
        }
        self.navigationController?.pushViewController(addNewNotesViewController, animated: true)
    }

     private func setNavigationTitle(){
         navigationController?.navigationBar.prefersLargeTitles = true
         navigationController?.navigationBar.isTranslucent = false
         navigationItem.title = navigationTitle
         setupNavBarAppearance()
    }
    
    func setupNavBarAppearance(){
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navBarAppearance.backgroundColor = AppThemeColor.themeBlackColor.value
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
        let  detailedNoteViewController = DetailedNoteViewController(notesInfo: selectedNoteInfo)
        self.navigationController?.pushViewController(detailedNoteViewController, animated: true)
    }
}

//MARK: - Data Format Helping Class
class DateParser {
    
    static func convertToFormatedDate(with timeInterval:Int) -> String{
        let date = NSDate(timeIntervalSince1970: TimeInterval(timeInterval))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = AppConstant.appDateFormat
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    }
}
