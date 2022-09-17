//
//  NotesCollectionViewCellTest.swift
//  CompostionalLayoutExerciseTests
//
//  Created by Abhishek Dhiman on 17/09/22.
//

import XCTest
@testable import CompostionalLayoutExercise

class NotesCollectionViewCellTest: XCTestCase {
    
    func test_whenInitialiseNotesCollectionViewCell_configuresNotesCollectionViewCellWithSuppliedData() {
        // ARRANGE
        let cell = createNotesCollectionViewCell()
        let date = Date.now
        let note = Note(id: UUID(), title: "test title", image: nil, description: "test description", creationDate: date, imageData: nil)
        let dateForAssertion = DateParser.convertToFormatedDate(with: Int(date.timeIntervalSince1970))
        
        // ACT
        cell.fillInfo(with: note)
        
        // ASSERT
        XCTAssertEqual(cell.titleLabel.text, note.title)
        XCTAssertEqual(cell.noteCreationDateLabel.text, dateForAssertion)
    }
    
    private func createNotesCollectionViewCell() -> NotesCollectionViewCell {
        return NotesCollectionViewCell(frame: .zero)
    }
}
