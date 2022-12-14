//
//  NoteServiceTest.swift
//  CompostionalLayoutExerciseTests
//
//  Created by Abhishek Dhiman on 16/09/22.
//

import XCTest
@testable import CompostionalLayoutExercise

class NoteServiceTest: XCTestCase {
    
    var noteService: NoteServiceProtocol?
    
    override func setUp() {
        super.setUp()
        noteService = ServiceFactory().createNoteService()
    }
    
    func test_noteService_With_ValidRequest_Returns_Success() {
        
        noteService?.getNotes(completion: { response in
            //ASSERT
            XCTAssertNotNil(response)
            XCTAssertEqual("How to grow your online presence",response?.first?.title)
        })
    }
}
