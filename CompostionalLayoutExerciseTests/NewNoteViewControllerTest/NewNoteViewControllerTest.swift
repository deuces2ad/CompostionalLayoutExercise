//
//  NewNoteViewControllerTest.swift
//  CompostionalLayoutExerciseTests
//
//  Created by Abhishek Dhiman on 17/09/22.
//

import XCTest
@testable import CompostionalLayoutExercise

class NewNoteViewControllerTest: XCTestCase {

    func test_CreateNewNote_Sends_Back_Same_Note() {
        
        // ARRANGE
        let newNoteViewController = NewNoteViewController()
        newNoteViewController.triggerLifecycleIfNeeded()
        let rootView =  AddNewNoteRootView()
        newNoteViewController.view = rootView
        let testTitle = "test title"
        let testDescription = "test description"
        let view = newNoteViewController.view as! AddNewNoteRootView
       
        // ACT
        newNoteViewController.loadView()
        rootView.newNoteTitleTextView.text = testTitle
        rootView.newNoteDescriptionTextView.text = testDescription
      
        // ASSERT
        XCTAssertEqual(view.newNoteTitleTextView.text, testTitle)
        XCTAssertEqual(view.newNoteDescriptionTextView.text, testDescription)
      
    }
}
