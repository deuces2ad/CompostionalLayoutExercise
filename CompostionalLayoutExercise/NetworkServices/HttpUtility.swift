//
//  HttpUtility.swift
//  CompostionalLayoutExercise
//
//  Created by Abhishek Dhiman on 15/09/22.
//

import Foundation

enum HTTPMethod : String {
    case GET = "GET"
}

final class HttpUtility {
    
    static let shared = HttpUtility()
    
    private init () {}
    
    func get(request: URLRequest,completion: @escaping (Result<Array<NoteResponseModel>,Error>)-> Void) {
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }
            guard let response = response as? HTTPURLResponse ,200...299 ~= response.statusCode else {
                //TODO: Fix this..:)
                return completion(.failure(error!))
            }
            if let data = data {
                if let result = self.decodeData(with: data){
                    completion(.success(result))
                }
            }
        }.resume()
    }
    
    private func decodeData(with data: Data) -> [NoteResponseModel]? {
        do {
            let decoded = try JSONDecoder().decode([NoteResponseModel].self, from: data)
            return decoded
        }
        catch let error {
            debugPrint(error)
        }
        return nil
    }
}
