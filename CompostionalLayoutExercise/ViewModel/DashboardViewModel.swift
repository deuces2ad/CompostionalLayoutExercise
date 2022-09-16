//
//  NotesDashboardViewModel.swift
//  CompositionalLayoutExercise
//
//  Created by Abhishek Dhiman on 10/09/22.
//

import Foundation

protocol DashboardViewModelProtocol : AnyObject {
    func getNotes(completion: @escaping ((Array<Note>?) -> Void))
    func saveNote(note: Note) -> Bool
}

class DashboardViewModel: DashboardViewModelProtocol {
    
    private let noteManager: NoteDataAccessorProtocol? = DataAccessorFactory().createNoteDataAccessor()
    private let noteService: NoteServiceProtocol? = ServiceFactory().createNoteService()
    
    //MARK: - Methods
    func getNotes(completion: @escaping (([Note]?) -> Void)) {
        isNotesFetchedAlreadyFromAPI() ?
        getNotesFromStorage(completion: completion) :
        getNotesFromService(completion: completion)
    }
    
    func saveNote(note: Note) -> Bool {
        
        /* let validationResult = noteValidation.validate(note)
         if(validationResult.Success) {
         // CREATE THE NOTE
         } else {
         // RETURN VALIDATION ERROR
         }*/
        return ((noteManager?.saveNote(note: note)) != nil)
    }
    
    //MARK: - Private Methods
    private func isNotesFetchedAlreadyFromAPI() -> Bool {
        return UserDefaults.standard.value(forKey: AppConstant.isNotesFetchedAlreadyFromAPI) as? Bool ?? false
    }
    
    private func getNotesFromService(completion: @escaping (Array<Note>?) -> Void) {
        
        noteService?.getNotes { [weak self] result in
            switch result {
            case .success(let notesResponse):
                guard let self = self else { return }
                let notesToSave = notesResponse.toNotes()
                self.createNotes(with: notesToSave)
                completion(notesToSave)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func createNotes(with notesToSave: [Note]) {
        let result = ((noteManager?.saveNotes(notes: notesToSave)) != nil)
        result ?
        UserDefaults.standard.setValue(true, forKey: AppConstant.isNotesFetchedAlreadyFromAPI) :
        UserDefaults.standard.setValue(false, forKey: AppConstant.isNotesFetchedAlreadyFromAPI)
    }
    
    private func getNotesFromStorage(completion: (([Note]?) -> Void)) {
        completion(noteManager?.fetchNote())
    }
}
