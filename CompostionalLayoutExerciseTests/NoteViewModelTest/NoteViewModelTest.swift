//
//  NoteViewModelTest.swift
//  CompostionalLayoutExerciseTests
//
//  Created by Abhishek Dhiman on 16/09/22.
//

import XCTest
@testable import CompostionalLayoutExercise

class NoteViewModelTest: XCTestCase {
    
    func test_When_executes_GetNotes_Returns_Notes_From_NoteService() {
        
        // ARRANGE
        let noteViewModel = NoteViewModelTestDouble(savesNote: true, isNotesSynced: true)

        // ACT
        noteViewModel.getNotes { notes in
            // ASSERT
            XCTAssertNotNil(notes)
            XCTAssertFalse(notes!.isEmpty)
        }
    }
    
    func test_When_executes_GetNotes_Returns_Notes_From_Storage() {
        // ARRANGE
        let noteViewModel = NoteViewModelTestDouble(savesNote: false, isNotesSynced: false)

        // ACT
        noteViewModel.getNotes { notes in
            // ASSERT
            XCTAssertNotNil(notes)
            XCTAssertFalse(notes!.isEmpty)
        }
    }
}


class NoteViewModelTestDouble: NoteViewModelProtocol {
    
    private let savesNotes: Bool
    private let isNotesSynced: Bool
    
    init(savesNote: Bool, isNotesSynced: Bool) {
        self.savesNotes = savesNote
        self.isNotesSynced = isNotesSynced
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
    
    func saveNote(note: CompostionalLayoutExercise.Note) -> SavingNoteResult {
        let noteManager = createNoteManager(savesNote: savesNotes)
        let result = noteManager.saveNote(note: note)
        if result {
            return SavingNoteResult(isSaved: noteManager.saveNote(note: note), errorMessage: nil)
        }
        return SavingNoteResult(isSaved: false, errorMessage: "Error")
    }
    
    func createNotesFromNoteService() -> NoteServiceProtocol {
        return ServiceFactory().createNoteService()
    }
    
    func createNoteManager(savesNote: Bool) -> NoteDataAccessorProtocol {
        if savesNote {
            return NoteDataAccessorValidStub()
        }
        return NoteDataAccessorInValidStub()
    }
    
    //MARK: - Private Methods
    private func createUserDefaultStub(isNoteSynced: Bool) -> UserDefaults {
        var userDefaults =  UserDefaults.init(suiteName: "notesSyncedUserDefault")!
        if isNoteSynced {
            userDefaults.set(true, forKey: AppConstant.isNotesSynced)
            return userDefaults
        }
        userDefaults.set(false, forKey: AppConstant.isNotesSynced)
        return userDefaults
    }
    
    func getNotesFromService() -> Array<Note> {
        return stubNotesFromService()
    }
    
    func getNotesFromStorage() -> Array<Note> {
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


class NoteDataAccessorValidStub: NoteDataAccessorProtocol {
    
    private var noteRepository: NoteRepository = NoteRepositoryFactory().createNoteRepository()
    
    func saveNote(note : Note) -> Bool {
       return false
    }
    
    func saveNotes(notes: Array<Note>) -> Bool {
        return noteRepository.saveNotes(notes: notes)
    }
    
    func fetchNote() -> Array<Note>? {
       return noteRepository.getAll()
    }
    
    func fetchNoteById(byIdentifier id: UUID) -> Note? {
        return noteRepository.get(byIdentifier: id)
    }
}

class NoteDataAccessorInValidStub: NoteDataAccessorProtocol {
    
    private var noteRepository: NoteRepository = NoteRepositoryFactory().createNoteRepository()
    
    func saveNote(note : Note) -> Bool {
       return true
    }
    
    func saveNotes(notes: Array<Note>) -> Bool {
        return noteRepository.saveNotes(notes: notes)
    }
    
    func fetchNote() -> Array<Note>? {
       return noteRepository.getAll()
    }
    
    func fetchNoteById(byIdentifier id: UUID) -> Note? {
        return noteRepository.get(byIdentifier: id)
    }
}

