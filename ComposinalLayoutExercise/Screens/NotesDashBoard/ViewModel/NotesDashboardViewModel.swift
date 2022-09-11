//
//  NotesDashboardViewModel.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 10/09/22.
//

import Foundation
import Combine

class NotesDashboardViewModel {
    
    //MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    var listner : (([NotesItemsModel])->())? = nil
    
    // get Notes from API service
    func getNotesItems(){
        FetchNotes.getNotes(with: NotesItemsModel.self)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            }
    receiveValue: { [weak self] notesInfo in
        guard let self = self else { return }
        self.listner?(notesInfo)
    }
    .store(in: &cancellables)
    }  
}
