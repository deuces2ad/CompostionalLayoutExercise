//
//  NoteResponseModelTest.swift
//  CompostionalLayoutExerciseTests
//
//  Created by Abhishek Dhiman on 16/09/22.
//

import XCTest
@testable import CompostionalLayoutExercise

final class NoteResponseModelTest: XCTestCase {
    
    func test_NoteResponseModel_With_ValidJSON_Return_Success () {
        // ARRANGE
        guard let path = Bundle.main.url(forResource:"validJson", withExtension: "json") else {
            fatalError("Can't find file")
        }

        // ACT
        let data = (try? Data(contentsOf: path))!

        // ASSERT
        let response = decodeData(with: data)
        XCTAssertNotNil(response)
    }
    
    func test_NoteResponseModel_With_InValidJSON_Return_Failure () {
        // ARRANGE
        guard let path = Bundle.main.url(forResource:"InvalidJson", withExtension: "json") else {
            fatalError("Can't find file")
        }
        
        // ACT
        let data = (try? Data(contentsOf: path))!
        
        // ASSERT
        let response = decodeData(with: data)
        XCTAssertNil(response)
    }
    
    func decodeData(with data: Data) -> [NoteResponseModel]? {
        do {
            let decoded = try JSONDecoder().decode([NoteResponseModel].self, from: data)
            return decoded
        }
        catch let error {
            debugPrint(error)
        }
        return nil
    }
    
    func test_NoteResponseModel_To_Get_Note_Returns_Success(){
        // ARRANGE
        let noteModel = NoteResponseModel(id: UUID().uuidString,
                                          archived: false,
                                          title: "this is test title",
                                          body: "this the body",
                                          createdTime: Int(Date.now.timeIntervalSince1970), image: nil,
                                          expiryTime: nil)
        
        // ACT
        let note = noteModel.toNote()
        
        // ASSERT
        XCTAssertNotNil(note)
    }
}
