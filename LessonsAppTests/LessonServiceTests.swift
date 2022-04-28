//
//  LessonServiceTests.swift
//  LessonsAppTests
//
//  Created by Mohammad Bitar on 4/28/22.
//

import Foundation
@testable import LessonsApp
import XCTest

class LessonServiceTests: XCTestCase {
    
    var urlSession: URLSession!

    
    func test_performsGETRequestWithURL() {
        let url = anyURL()
        let exp = expectation(description: "Wait for request")
        
        URLProtocolStub.requestHandler = { request in
            XCTAssertEqual(request.url, url)
            XCTAssertEqual(request.httpMethod, "GET")
            exp.fulfill()
            return (HTTPURLResponse(), Data("any data".utf8))
        }
        makeSUT().get(from: url, completion: { _ in })
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_performGETRequestWithURLWithSuccessResponse() {
        let data = anyData()
        let response = anyResponse()
        let exp = expectation(description: "Wait for request")
        
        URLProtocolStub.requestHandler = { _ in
            return (response, data)
        }
        
        makeSUT().get(from: anyURL()) { result in
            switch result {
            case .success(let values):
                XCTAssertEqual(values.data, data)
                XCTAssertEqual(values.response.url, response.url)
                XCTAssertEqual(values.response.statusCode, response.statusCode)
            
            case .failure(let error):
                XCTFail("Error was not expected: \(error)")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_performGETRequestWithEmptyDataWithSuccessResponse() {
        let data = Data()
        let response = anyResponse()
        let exp = expectation(description: "Wait for request")
        
        URLProtocolStub.requestHandler = { _ in
            return (response, nil)
        }
        
        makeSUT().get(from: anyURL()) { result in
            switch result {
            case .success(let values):
                XCTAssertEqual(values.data, data)
                XCTAssertEqual(values.response.url, response.url)
                XCTAssertEqual(values.response.statusCode, response.statusCode)
            
            case .failure(let error):
                XCTFail("Error was not expected: \(error)")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_failsOnRequestError() {
        let exp = expectation(description: "Wait for request")
        
        URLProtocolStub.requestHandler = { _ in
            return (nil, nil)
        }
        
        makeSUT().get(from: anyURL()) { result in
            switch result {
            case .success:
                XCTFail("Success response was not expected.")
            
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        
        let sut = URLSessionHTTPClient(session: session)
        return sut
    }
}
