//
//  NoteViewModelTest.swift
//  CompostionalLayoutExerciseTests
//
//  Created by Abhishek Dhiman on 16/09/22.
//

import Foundation
@testable import CompostionalLayoutExercise

class NoteViewModelTestDouble: NoteViewModelProtocol {
    
    private let savesNotes: Bool
    private let isNotesSynced: Bool
    private var isValidNote: Bool?
    private var noteValidation: NoteValidationProtocol
    private var noteDataAccessor: NoteDataAccessorProtocol?
    
    init(savesNote: Bool, isNotesSynced: Bool) {
        self.savesNotes = savesNote
        self.isNotesSynced = isNotesSynced
        self.noteValidation = NoteValidationStub(success: false, errorMessage: nil)
    }
    
    convenience init(isValidNote: Bool) {
        self.init(savesNote: true, isNotesSynced: true)
        self.isValidNote = isValidNote
        self.noteValidation = NoteValidationStub(success: isValidNote, errorMessage: isValidNote ? nil : "Error")
        self.noteDataAccessor = createNoteDataAccessor(isValidNote: isValidNote)
    }
    
    func getNotes(completion: @escaping ((Array<CompostionalLayoutExercise.Note>?) -> Void)) {
        let userDefaults = createUserDefaultStub(isNoteSynced: isNotesSynced)
        let notesSyncStatus = userDefaults.value(forKey: AppConstant.isNotesSynced) as! Bool
        if notesSyncStatus {
            completion(stubNotesFromStorage())
        } else {
            completion(stubNotesFromService())
        }
    }
    
    func saveNote(note: Note) -> SavingNoteResult {
        let validationResult = noteValidation.validate(note: note)
        if validationResult.success {
            return SavingNoteResult(isSaved: noteDataAccessor?.saveNote(note: note) ?? false, errorMessage: nil)
        }
        return SavingNoteResult(isSaved: validationResult.success, errorMessage: validationResult.errorMessage)
    }
    
    func createNotesFromNoteService() -> NoteServiceProtocol {
        return ServiceFactory().createNoteService()
    }
    
    func createNoteDataAccessor(isValidNote: Bool) -> NoteDataAccessorProtocol? {
        if isValidNote {
            return NoteDataAccessorValidStub()
        }
        return NoteDataAccessorInValidStub()
    }
    
    //MARK: - Private Methods
    private func createUserDefaultStub(isNoteSynced: Bool) -> UserDefaults {
        let userDefaults =  UserDefaults.init(suiteName: "notesSyncedUserDefault")!
        if isNoteSynced {
            userDefaults.set(true, forKey: AppConstant.isNotesSynced)
            return userDefaults
        }
        userDefaults.set(false, forKey: AppConstant.isNotesSynced)
        return userDefaults
    }
    
    private func getNotesFromService() -> Array<Note> {
        return stubNotesFromService()
    }
    
    private func getNotesFromStorage() -> Array<Note> {
        return stubNotesFromStorage()
    }
    
    private func stubNotesFromService() -> [Note] {
        return  [Note(id: UUID(), title: "test title", image: nil, description: "test description", creationDate: Date(), imageData: nil)]
    }
    
    private func stubNotesFromStorage() -> [Note] {
        return  [Note(id: UUID(), title: "test title", image: nil, description: "test description", creationDate: Date(), imageData: nil),
                 Note(id: UUID(), title: "Another test title ", image: nil, description: "Another test description", creationDate: Date(), imageData: nil)]
    }
    
}
