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

enum ErrorType: Error {
    case InvalidURL
    case decodeFailure
}

protocol HttpUtilityProtocol {
    func get(request: URLRequest,completion: @escaping (Result<Array<NoteResponseModel>,ErrorType>)-> Void)
}
final class HttpUtility: HttpUtilityProtocol {
    
    static let shared = HttpUtility()
    
    private init () {}
    
    func get(request: URLRequest,completion: @escaping (Result<Array<NoteResponseModel>,ErrorType>)-> Void) {
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                return completion(.failure(ErrorType.InvalidURL))
            }
            guard let response = response as? HTTPURLResponse ,200...299 ~= response.statusCode else {
                return completion(.failure(ErrorType.InvalidURL))
            }
            if let data = data {
                if let result = self.decodeData(with: data){
                    completion(.success(result))
                }else{
                    completion(.failure(ErrorType.decodeFailure))
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

extension ErrorType : LocalizedError {
    
    var message : String {
        switch self {
        case .InvalidURL:
            return NSLocalizedString(ServiceError.invalidURL, comment: ServiceError.invalidURL)
            
        case .decodeFailure:
            return NSLocalizedString(ServiceError.decodeFailure, comment: ServiceError.decodeFailure)
        }
    }
}
