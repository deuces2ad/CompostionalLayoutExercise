//
//  FetchNotesService.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 10/09/22.
//

import Foundation
import Combine


class FetchNotes {
     static var cancellable = Set<AnyCancellable>()
    
    static func getNotes<T:Decodable>(with type: T.Type) -> Future<[T],Error>{
        return Future{ promise in
            let urlString = AppInfo.webServiceURL
            guard let request = URL(string: urlString) else {
                return promise(.failure(NetworkError.InvalidURL))
            }
            URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { (data,response) -> Data in
                    guard let response = response as? HTTPURLResponse ,200...299 ~= response.statusCode else {
                        throw NetworkError.InvalidURL
                    }
                    return data
                }
                .decode(type: [T].self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    switch completion {
                    case .finished:
                        print("Note Fetched successfully!")
                    case .failure(_):
                        promise(.failure(NetworkError.InvalidURL))
                    }
                }, receiveValue: {promise(.success($0))})
                .store(in: &cancellable)
        }
    }
}

enum NetworkError {
    case InvalidURL
}

extension NetworkError : LocalizedError {
    var errorMessage : String? {
        switch self {
        case .InvalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        }
    }
    
}
