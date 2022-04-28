//
//  LessonMapperTests.swift
//  LessonsAppTests
//
//  Created by Mohammad Bitar on 4/28/22.
//

import XCTest
@testable import LessonsApp

class LessonMapperTests: XCTestCase {
    
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = makeJson([])
        
        let samples = [199, 201, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try LessonMapper.map(json, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() throws {
        let invalidJSON = Data("invalid json".utf8)
        
        XCTAssertThrowsError(
            try LessonMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversNoLocationsOn200HTTPResponseWithEmptyJsonList() throws {
        let json = makeJson([])
        let result = try LessonMapper.map(json, from:
            HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [])
    }
    
    func test_map_deliversLocationsOn200HTTPResponseWithJSONItems() throws {
        let lesson1 = makeLesson(id: 1, name: "name 1", description: "description 1", thumbnail: URL(string: "http://any-url.com")!, videoUrl: URL(string: "http://aanother-url.com")!)
        let lesson2 = makeLesson(id: 2, name: "name 2", description: "description 2", thumbnail: URL(string: "http://any-url.com")!, videoUrl: URL(string: "http://aanother-url.com")!)
        
        let json = makeJson([lesson1.json, lesson2.json])
        
        let result = try LessonMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [lesson1.model, lesson2.model])
    }
}
