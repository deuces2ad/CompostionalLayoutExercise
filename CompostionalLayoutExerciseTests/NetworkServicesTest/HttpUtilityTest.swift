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
            case .failure(let error):
                XCTAssertNil(error)
                expectation.fulfill()
            }
        })
        waitForExpectations(timeout: 3)
    }
    
    //TODO: Need to check up...
//    func test_HttpUtility_With_InValidRequest_Returns_Failure() {
//
//        // ARRANGE
//        let invalidUrl = URL(string: "https://httpbin.org/get")!
//        let request = createURLRequest(url: invalidUrl)
//        let httpUtility = HttpUtility.shared
//        let expectation = expectation(description: "ValidRequest_Returns_Success")
//
//        // ACT
//        httpUtility.get(request: request, completion: { response in
//
//            switch response {
//            case .success(let response):
//                XCTAssertNil(response)
//            case .failure(let error):
//                // ASSERT
//                XCTAssertNotNil(error)
//                expectation.fulfill()
//            }
//        })
//        waitForExpectations(timeout: 10)
//    }
    
    //MARK: - Create URL Request
    private func createURLRequest(url: URL = ServiceEndPoint.getNotes!) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        return request
    }
}
