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
    
    private let noteDataAccessor: NoteDataAccessorProtocol? = DataAccessorFactory().createNoteDataAccessor()
    private let noteService: NoteServiceProtocol? = ServiceFactory().createNoteService()
    private let noteValidation: NoteValidation = NoteValidation()
    
    //MARK: - Methods
    func getNotes(completion: @escaping ((Array<Note>?) -> Void)) {
        isNotesSynced() ?
        getNotesFromStorage(completion: completion) :
        getNotesFromService(completion: completion)
    }
    
    func saveNote(note: Note) -> SavingNoteResult {
        let validationResult = noteValidation.validate(note: note)
        if validationResult.success {
            return SavingNoteResult(isSaved: noteDataAccessor?.saveNote(note: note) ?? false, errorMessage: nil)
        }
        return SavingNoteResult(isSaved: validationResult.success, errorMessage: validationResult.errorMessage)
    }
    
    //MARK: - Private Methods
    private func isNotesSynced() -> Bool {
        return UserDefaults.standard.value(forKey: AppConstant.isNotesSynced) as? Bool ?? false
    }
    
    private func getNotesFromService(completion: @escaping (Array<Note>?) -> Void) {
        
        noteService?.getNotes { [weak self] notesResponse in
            if(notesResponse == nil) { completion(nil) }
            guard let self = self else { return }
            self.createNotes(with: notesResponse ?? [])
            completion(notesResponse)
        }
    }
    
    private func createNotes(with notesToSave: [Note]) {
        guard notesToSave.isEmpty else { return }
        let result = ((noteDataAccessor?.saveNotes(notes: notesToSave)) != nil)
        result ?
        UserDefaults.standard.setValue(true, forKey: AppConstant.isNotesSynced) :
        UserDefaults.standard.setValue(false, forKey: AppConstant.isNotesSynced)
    }
    
    private func getNotesFromStorage(completion: (([Note]?) -> Void)) {
        completion(noteDataAccessor?.fetchNote())
    }
}

struct SavingNoteResult {
    let isSaved: Bool
    let errorMessage: String?
}
