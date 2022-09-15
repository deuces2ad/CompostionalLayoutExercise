//
//  NoteService.swift
//  CompositionalLayoutExercise
//
//  Created by Abhishek Dhiman on 10/09/22.
//

import Foundation

protocol NoteServiceProtocol : AnyObject {
    func getNotes(completion: @escaping (Result<Array<NoteResponseModel>,Error>)-> Void)
}

class NoteService: NoteServiceProtocol {
    
    func getNotes(completion: @escaping (Result<Array<NoteResponseModel>,Error>)-> Void){
        
        guard let url = ServiceEndPoint.getNotes else {return}
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        HttpUtility.shared.get(request: request) { response in
            completion(response)
        }
    }
}
