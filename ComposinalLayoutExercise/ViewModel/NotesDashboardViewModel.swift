//
//  NotesDashboardViewModel.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 10/09/22.
//

 
import Foundation

class NotesDashboardViewModel {
    
    //MARK: - Properties
    var noteItemsListener : (([NoteInformation])-> Void)? = nil
    
    //MARK: - Methods
    func checkIfNotesPreFetchedFromAPI() -> Bool{
        if let result = UserDefaults.standard.value(forKey: AppConstant.isNotesFetchedAlreadyFromAPI) as? Bool{
            return result
        }else{
            return false
        }
    }
    
    func getNotesItems() {
        if !checkIfNotesPreFetchedFromAPI(){
            fetchNotesFromAPI()
        }else{
            loadItemsFromLocalDataBase()
        }
    }
    
    private func fetchNotesFromAPI(){
        NoteService.getNotes { [weak self] result in
            switch result {
            case .success(let items):
                let noteInformation_items  = ConvertObjects.fetch_all_NoteInformation(from: items)
                self?.noteItemsListener?(noteInformation_items)
                self?.saveNoteToLocalDataBase(for: noteInformation_items)
                UserDefaults.standard.setValue(true, forKey: AppConstant.isNotesFetchedAlreadyFromAPI)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveNoteToLocalDataBase(for items : [NoteInformation]){
        _ =  items.map{NoteManager().createNote(note: $0)}
    }
    
    private func loadItemsFromLocalDataBase(){
        guard let items = NoteManager().fetchNote() else {return}
        if items.count == 0 {fetchNotesFromAPI()}
        self.noteItemsListener!(items)
    }
}
