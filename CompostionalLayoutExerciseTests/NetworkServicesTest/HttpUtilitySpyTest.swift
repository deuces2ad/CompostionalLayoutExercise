//
//  HttpUtilitySpyTest.swift
//  CompostionalLayoutExerciseTests
//
//  Created by Abhishek Dhiman on 16/09/22.
//

import XCTest
@testable import CompostionalLayoutExercise

class HttpUtilitySpy: HttpUtilityProtocol {
    
    var capturedRequest = [(request: URLRequest, completion: (Result<Array<CompostionalLayoutExercise.NoteResponseModel>, Error>) -> Void)]()
    var requests: [URLRequest] {
        return capturedRequest.map{ $0.request }
    }
    
    
    func get(request: URLRequest, completion: @escaping (Result<Array<CompostionalLayoutExercise.NoteResponseModel>, Error>) -> Void) {
        capturedRequest.append((request, completion))
    }
}

class HttpUtilitySpyTest: XCTestCase {
    
    func test_Given_HttpUility_Conforms_To_HttpUtilitySpy() {
        
        // ARRANGE
        let httpUtility = createHttpUtility() as? HttpUtilitySpy
        
        // ASSERT
        XCTAssert((httpUtility as AnyObject) is HttpUtilitySpy)
    }
    
    func test_init_does_Not_Get_Requested_Data() {
        
        // ARRANGE
        let httpUtility = createHttpUtility() as? HttpUtilitySpy
        
        // ASSERT
        XCTAssertEqual(httpUtility?.capturedRequest.count, 0)
    }
    
    func test_givenURL_sendsRequestToLoadData() {
        
        // ARRANGE
        let request = createURLRequest()
        let httpUtility = createHttpUtility() as? HttpUtilitySpy
        
        // ACT
        httpUtility?.get(request: request, completion: { _ in})
        
        // ASSERT
        XCTAssertEqual(httpUtility?.requests , [request])
    }
    
    func test_givenURL_When_Called_Twice_Request_Data_Twice() {
        
        // ARRANGE
        let request = createURLRequest()
        let httpUtility = createHttpUtility() as? HttpUtilitySpy
        
        // ACT
        httpUtility?.get(request: request, completion: { _ in})
        httpUtility?.get(request: request, completion: { _ in})
        
        // ASSERT
        XCTAssertEqual(httpUtility?.requests , [request, request])
    }
    
    private func createURLRequest(url: URL = ServiceEndPoint.getNotes!) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        return request
    }
    
    private func createHttpUtility() -> HttpUtilityProtocol {
        return HttpUtilitySpy()
    }
    
}
