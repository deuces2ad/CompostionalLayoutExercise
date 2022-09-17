//
//  NotesDashBoardViewControllerTest.swift
//  CompostionalLayoutExerciseTests
//
//  Created by Abhishek Dhiman on 17/09/22.
//

import XCTest
@testable import CompostionalLayoutExercise

class NotesDashBoardViewControllerTest: XCTestCase {
    
    func test_WhenInitilise_LoadNote_In_the_View() {
        
        // ARRANGE

        let noteDashboardViewController = NotesDashBoardViewController()
        let viewModel = NoteViewModelTestDouble(isValidNote: true)
        noteDashboardViewController.dashboardViewModel = viewModel
        noteDashboardViewController.triggerLifecycleIfNeeded()
        let view = noteDashboardViewController.view as! NotesRootView
        let noteCollectionView = view.notesCollectionView
      
        // ACT
        noteCollectionView.reloadData()
        
        // ASSERT
        let numberOfItems = noteCollectionView.numberOfItems(inSection: 0)
        XCTAssertEqual(numberOfItems, viewModel.stubNotesFromStorage().count)
    }
}
