//
//  NoteService.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 10/09/22.
//

import Foundation
 


//class NoteService
//
enum NetworkError : Error {
    case InvalidURL
}

enum HTTPMethod : String {
    case GET = "GET"
}

class NoteService  {
    
    static func getNotes(completion: @escaping (Result<[NoteResponseModel],Error>)-> Void) {
        
        guard let url = ServiceEndPoint.getNotes else {
            return completion(.failure(NetworkError.InvalidURL))
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.GET.rawValue
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }
            guard let response = response as? HTTPURLResponse ,200...299 ~= response.statusCode else {
                return completion(.failure(NetworkError.InvalidURL))
            }
            if let data = data {
                if let result = decodeData(with: data){
                    completion(.success(result))
                }
            }
        }.resume()
    }
    
    static func decodeData(with data: Data) -> [NoteResponseModel]? {
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

extension NetworkError : LocalizedError {
    var errorMessage : String? {
        switch self {
        case .InvalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        }
    }
}
