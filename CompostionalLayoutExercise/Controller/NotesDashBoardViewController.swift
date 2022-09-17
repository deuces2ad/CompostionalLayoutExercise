//
//  ViewController.swift
//  CompositionalLayoutExercise
//
//  Created by Abhishek Dhiman on 09/09/22.
//

import UIKit

class NotesDashBoardViewController: UIViewController {
    
    //MARK: - Private variables
    var dashboardViewModel: NoteViewModelProtocol = NoteViewModelFactory.createNoteViewModel()
    private let cardBackgroundCount = ApplicationColor.cardBackgrounds.count
    private let rootView: NotesRootView = NotesRootView()
    private var colorIndex = UIConstant.firstColorIndex
    var notesItems = [Note]()
    
    //MARK: - LifeCycle methods
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func initialSetup() {
        checkInternetStatus()
        registerListeners()
        setNavigationTitle()
        configureCollectionViewCell()
        
    }
    
    //MARK: - Methods
    private func configureCollectionViewCell() {
        self.rootView.notesCollectionView.delegate = self
        self.rootView.notesCollectionView.dataSource = self
        self.rootView.notesCollectionView.register(NotesCollectionViewCell.self, forCellWithReuseIdentifier: NotesCollectionViewCell.cellIdentifier)
    }
    
    private func registerListeners() {
        //receive  Note Items
        dashboardViewModel.getNotes { [weak self] notes in
            self?.populateNotesItems(with: notes!)
        }
        //Add New Note
        rootView.newNoteActionListener =  { [weak self]  in
            self?.navigateToNewNoteViewController()
        }
    }
    
    private func populateNotesItems(with items: [Note]) {
        self.notesItems = items
        DispatchQueue.main.async {
            self.rootView.notesCollectionView.reloadData()
        }
    }
    
    private func navigateToNewNoteViewController() {
        let addNewNotesViewController = NewNoteViewController()
        addNewNotesViewController.newNoteListener = {  newNote in
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.navigationBar.prefersLargeTitles = false
            let result = self.dashboardViewModel.saveNote(note: newNote)
            if(result.isSaved) {
                self.notesItems.append(newNote)
                DispatchQueue.main.async {
                    self.rootView.notesCollectionView.reloadData()
                }
            }else {
                self.showAlert(with: UIConstant.alertTitle, message: result.errorMessage ?? AppConstant.emptyString)
            }
        }
        self.navigationController?.pushViewController(addNewNotesViewController, animated: true)
    }
    
    private func setNavigationTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = UIConstant.navigationTitle
        setupNavBarAppearance()
    }
    
    func setupNavBarAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navBarAppearance.backgroundColor = ApplicationColor.darkBackground
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func checkInternetStatus() {
        if !InternetConnectivity.shared.isConnectionStable {
            showAlert(with: UIConstant.noInternet, message: UIConstant.noInternetAlertMessage)
        }
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
            self.colorIndex += colorIndex < (cardBackgroundCount - 1)  ? 1 : -(cardBackgroundCount - 1)
            cell.backgroundColor = ApplicationColor.cardBackgrounds[colorIndex]
            return cell
        }
        return UICollectionViewCell()
    }
}

extension NotesDashBoardViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedNoteInfo = self.notesItems[indexPath.row]
        let detailedNoteViewController = DetailedNoteViewController(notesInfo: selectedNoteInfo)
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
