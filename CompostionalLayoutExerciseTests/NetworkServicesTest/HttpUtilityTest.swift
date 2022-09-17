//
//  HttpUtilityTest.swift
//  CompostionalLayoutExerciseTests
//
//  Created by Abhishek Dhiman on 16/09/22.
//

import XCTest
@testable import CompostionalLayoutExercise

class HttpUtilityTest: XCTestCase {
    
    func test_Get_WithValidRequest_Returns_NoteResponseModelCollection() {
        
        // ARRANGE
        let request = createURLRequest()
        let httpUtility = HttpUtility.shared
        let expectation = expectation(description: "NoteResponseModelCollection")
        
        // ACT
        httpUtility.get(request: request, completion: { response in
            
            switch response {
            case .success(let noteCollection):
                // ASSERT
                XCTAssertNotNil(response)
                XCTAssertNotNil(noteCollection)
                XCTAssertFalse(noteCollection.isEmpty)
                XCTAssertEqual(noteCollection.first?.title, "How to grow your online presence")
                expectation.fulfill()
            case .failure(_): break
            }
        })
        waitForExpectations(timeout: 3)
    }
    
    func test_HttpUtility_With_NonExistingURL_Returns_Failure() {
        
        // ARRANGE
        let invalidUrl = URL(string: "https://raw.githubusercontent.com/RishabhRaghunath/JustATest/master/nots")!
        let request = createURLRequest(url: invalidUrl)
        let httpUtility = HttpUtility.shared
        let expectation = expectation(description: "ValidRequest_Returns_Success")
        
        // ACT
        httpUtility.get(request: request) { response in
            switch response {
            case .success(_):break
            case .failure(let errorType):
                // ASSERT
                XCTAssertNotNil(errorType)
                XCTAssertEqual(ServiceError.invalidURL, errorType.message)
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 3)
    }
    
    func test_Get_With_InvalidRequest_Returns_Failure() {
        
        // ARRANGE
        let invalidUrl = URL(string: "https://httpbin.org/get")!
        let request = createURLRequest(url: invalidUrl)
        let httpUtility = HttpUtility.shared
        let expectation = expectation(description: "ValidRequest_Returns_Success")
        
        // ACT
        httpUtility.get(request: request, completion: { response in
            
            switch response {
            case .success(_): break
            case .failure(let error):
                // ASSERT
                XCTAssertNotNil(error)
                XCTAssertEqual(ServiceError.decodeFailure, error.message)
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 3)
    }
    
    //MARK: - Create URL Request
    private func createURLRequest(url: URL = ServiceEndPoint.getNotes!) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        return request
    }
}
