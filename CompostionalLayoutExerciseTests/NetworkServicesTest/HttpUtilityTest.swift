//
//  HttpUtilityTest.swift
//  CompostionalLayoutExerciseTests
//
//  Created by Abhishek Dhiman on 16/09/22.
//

import XCTest
@testable import CompostionalLayoutExercise

final class HttpUtilityTest: XCTestCase {
    
    var httpUtility: HttpUtility?
    
    override  func setUp() {
        super.setUp()
        httpUtility = HttpUtility.shared
    }
    
    func test_HttpUtility_With_ValidRequest_Returns_Success() {
        
        // ARRANGE
        let url = URL(string:"https://raw.githubusercontent.com/RishabhRaghunath/JustATest/master/notes")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let expectation = expectation(description: "ValidRequest_Returns_Success")
        
        // ACT
        httpUtility?.get(request: request, completion: { response in
            
            switch response {
            case .success(let noteCollection):
                // ASSERT
                XCTAssertNotNil(response)
                XCTAssertNotNil(noteCollection)
                XCTAssertEqual(noteCollection.first?.title, "How to grow your online presence")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error)
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 5)
    }
    
    func test_HttpUtility_With_InValidRequest_Returns_Failure() {
        
        // ARRANGE
        let url = URL(string:"https://raw.githubusercontent.com/RishabhRaghunath/JustATest/master/note")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let expectation = expectation(description: "ValidRequest_Returns_Success")
        
        // ACT
        httpUtility?.get(request: request, completion: { response in
            
            switch response {
            case .success(let response):
                XCTAssertNil(response)
            case .failure(let error):
                // ASSERT
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 5)
    }
}
