//
//  DetailedNoteViewControllerTest.swift
//  CompostionalLayoutExerciseTests
//
//  Created by Abhishek Dhiman on 17/09/22.
//

import XCTest
@testable import CompostionalLayoutExercise

class DetailedNoteViewControllerTest: XCTestCase {


    func test_WhenInitialise_ViewLoads() {
        
        // ARRANGE
        let testTitle = "test title"
        let testId = UUID()
        let testDescription = "test description"
        let date = Date()
        let note = Note(id: testId, title: testTitle, image: nil, description: testDescription, creationDate: date, imageData: nil)
        let dateForAssertion = DateParser.convertToFormatedDate(with: Int(note.creationDate.timeIntervalSince1970))
        
        let detailedNoteViewController = DetailedNoteViewController(notesInfo: note)
        detailedNoteViewController.triggerLifecycleIfNeeded()
        let rootView = DetailedNoteRootView()
        detailedNoteViewController.view = rootView
       
        let view = detailedNoteViewController.view as! DetailedNoteRootView
       
        // ACT
        view.fillInfo(with: note)
      
        // ASSERT
        XCTAssertEqual(view.noteTitle.text, testTitle)
        XCTAssertEqual(view.noteDescriptionTxtView.text, testDescription)
        XCTAssertEqual(view.noteCreatedDateLabel.text, dateForAssertion)
        
    }
}
