//
//  NotesDashboardViewModel.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 10/09/22.
//

import Foundation

class NotesDashboardViewModel {
    
    private let noteManager = NoteManager()
    
    //MARK: - Methods
   
    func getNotes(completion: @escaping (([Note]?) -> Void)) {
        isNotesFetchedAlreadyFromAPI() ?
        getNotesFromStorage(completion: completion) :
        getNotesFromService(completion: completion)
    }
    
    //MARK: - Private Methods
    
    private func isNotesFetchedAlreadyFromAPI() -> Bool {
        if let result = UserDefaults.standard.value(forKey: AppConstant.isNotesFetchedAlreadyFromAPI) as? Bool {
            return result
        }else{
            return false
        }
    }
    
    private func getNotesFromService(completion: @escaping (([Note]?) -> Void)) {
        NoteService().getNotes { [weak self] result in
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
        for item in items {
            noteManager.createNote(note: item)
        }
    }
    
    private func getNotesFromStorage(completion: (([Note]?) -> Void)) {
        completion(noteManager.fetchNote())
    }
}
