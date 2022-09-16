//
//  NotesDashboardViewModel.swift
//  CompositionalLayoutExercise
//
//  Created by Abhishek Dhiman on 10/09/22.
//

import Foundation

protocol NoteViewModelProtocol: AnyObject {
    func getNotes(completion: @escaping ((Array<Note>?) -> Void))
    func saveNote(note: Note) -> SavingNoteResult
}

class NoteViewModel: NoteViewModelProtocol {
    
    private let noteManager: NoteDataAccessorProtocol? = DataAccessorFactory().createNoteDataAccessor()
    private let noteService: NoteServiceProtocol? = ServiceFactory().createNoteService()
    private let noteValidation: NoteValidation = NoteValidation()
    
    //MARK: - Methods
    func getNotes(completion: @escaping ((Array<Note>?) -> Void)) {
        isNotesFetchedAlreadyFromAPI() ?
        getNotesFromStorage(completion: completion) :
        getNotesFromService(completion: completion)
    }
    
    func saveNote(note: Note) -> SavingNoteResult {
        let validationResult = noteValidation.validate(note: note)
        if validationResult.success {
            return SavingNoteResult(isSaved: noteManager?.saveNote(note: note) ?? false, errorMessage: nil)
        }
        return SavingNoteResult(isSaved: validationResult.success, errorMessage: validationResult.errorMessage)
    }
    
    //MARK: - Private Methods
    private func isNotesFetchedAlreadyFromAPI() -> Bool {
        return UserDefaults.standard.value(forKey: AppConstant.isNotesSynced) as? Bool ?? false
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
        UserDefaults.standard.setValue(true, forKey: AppConstant.isNotesSynced) :
        UserDefaults.standard.setValue(false, forKey: AppConstant.isNotesSynced)
    }
    
    private func getNotesFromStorage(completion: (([Note]?) -> Void)) {
        completion(noteManager?.fetchNote())
    }
}

//TODO: Need to check this name
struct SavingNoteResult {
    let isSaved: Bool
    let errorMessage: String?
}
