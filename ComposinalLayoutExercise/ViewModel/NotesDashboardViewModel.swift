//
//  NotesDashboardViewModel.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 10/09/22.
//

import Combine
import Foundation

class NotesDashboardViewModel {
    
    //MARK: - Properties
    private var cancelable = Set<AnyCancellable>()
    @Published var listener = [NotesItemModel]()
    
    // get Notes from API service
    func getNotesItems() {
        FetchNotes.getNotes(with: NotesItemModel.self)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                   break
                }
            }
    receiveValue: { [weak self] notesInfo in
        guard let self = self else { return }
        self.listener = notesInfo
    }
    .store(in: &cancelable)
    }
    
    func createNewModelInfo(with item : NoteInformation) -> NotesItemModel {
        return NotesItemModel(id: "1", archived: false, title: item.noteTitle, body: item.noteDescription, createdTime: Int((Date().timeIntervalSince1970)), image: "\(item.noteImage ?? Data())", expiryTime: nil)
    }
    
    func createNoteModelFromNotesInformation(with notes: [NoteInformation]) -> [NotesItemModel]{
        return notes.map{self.createNewModelInfo(with: $0)}
    }
    
}
