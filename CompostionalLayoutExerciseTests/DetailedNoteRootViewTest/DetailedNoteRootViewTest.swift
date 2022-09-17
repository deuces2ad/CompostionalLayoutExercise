//
//  DetailedNoteRootViewTest.swift
//  CompostionalLayoutExerciseTests
//
//  Created by Abhishek Dhiman on 17/09/22.
//

import XCTest
@testable import CompostionalLayoutExercise

class DetailedNoteRootViewTest: XCTestCase {

    func test_Receiveda_Note_Data_Shows_The_Same_Data() {
        
        // ARRANGE
        let rootView = DetailedNoteRootView()
        rootView.layoutSubviews()
        let testTitle = "test title"
        let testId = UUID()
        let testDescription = "test description"
        let date = Date()
        let note = Note(id: testId, title: testTitle, image: nil, description: testDescription, creationDate: date, imageData: nil)
        
        let dateForAssertion = DateParser.convertToFormatedDate(with: Int(note.creationDate.timeIntervalSince1970))
       
        // ACT
        rootView.fillInfo(with: note)
        
        // ASSERT
        XCTAssertEqual(rootView.noteTitle.text, testTitle)
        XCTAssertEqual(rootView.noteDescriptionTxtView.text, testDescription)
        XCTAssertEqual(rootView.noteCreatedDateLabel.text, dateForAssertion)
    }
}
