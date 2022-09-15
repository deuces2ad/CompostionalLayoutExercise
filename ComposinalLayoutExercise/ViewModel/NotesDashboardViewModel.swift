//
//  NotesDashboardViewModel.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 10/09/22.
//

import Foundation

class NotesDashboardViewModel {
    
    typealias Action = (([Note]?) -> Void)
    private let noteManager = NoteManager()
    
    //MARK: - Methods
    func isNotesSynced() -> Bool {
        if let result = UserDefaults.standard.value(forKey: AppConstant.isNotesFetchedAlreadyFromAPI) as? Bool {
            return result
        }else{
            return false
        }
    }
    
    func getNotes(completion: @escaping Action) {
        isNotesSynced() ?
        loadItemsFromLocalDataBase(completion: completion) :
        fetchNotesFromAPI(completion: completion)
    }
    
    //MARK: - Private Methods
    private func fetchNotesFromAPI(completion: @escaping Action) {
        NoteService.getNotes { [weak self] result in
            switch result {
            case .success(let items):
                guard let self = self else { return }
                let notes = ConvertObjects.fetch_all_NoteInformation(from: items)
                self.createNotes(for: notes)
                completion(notes)
                UserDefaults.standard.setValue(true, forKey: AppConstant.isNotesFetchedAlreadyFromAPI)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func createNotes(for items : [Note]) {
        _ =  items.map{ noteManager.createNote(note: $0) }
    }
    
    private func loadItemsFromLocalDataBase(completion: Action) {
        completion(noteManager.fetchNote())
    }
}
