//
//  AddNewNoteRootViewTest.swift
//  CompostionalLayoutExerciseTests
//
//  Created by Abhishek Dhiman on 17/09/22.
//

import XCTest
@testable import CompostionalLayoutExercise

 class AddNewNoteRootViewTest: XCTestCase {

     func test_When_Filled_Data_In_RootView_Save_SameData_DataBase() {
         
         // ARRANGE
         let rootView = AddNewNoteRootView()
         rootView.layoutSubviews()
         let testTitle = "test title"
         let testDescription = "test description"
        
         // ACT
         rootView.newNoteTitleTextView.text = testTitle
         rootView.newNoteDescriptionTextView.text = testDescription
         
         // ASSERT
         XCTAssertEqual(rootView.newNoteTitleTextView.text, testTitle)
         XCTAssertEqual(rootView.newNoteDescriptionTextView.text, testDescription)
     }
}
