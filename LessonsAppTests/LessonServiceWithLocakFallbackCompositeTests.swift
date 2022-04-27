//
//  LessonServiceWithLocakFallbackCompositeTests.swift
//  LessonsAppTests
//
//  Created by Mohammad Bitar on 4/25/22.
//

import XCTest
@testable import LessonsApp

class LessonServiceWithLocakFallbackComposite: LessonService {
    private let primary: LessonService
    
    init(primary: LessonService, fallback: LessonService) {
        self.primary = primary
    }
    
    func getLessons(completion: @escaping (LessonService.Result) -> Void) {
        primary.getLessons(completion: completion)
    }
}

class LessonServiceWithLocakFallbackCompositeTests: XCTestCase {

    func test_load_deliversPrimaryLessonsOnPrimarySuccess() {
        let primaryLessons = uniqueLessons()
        let fallbackLessons = uniqueLessons()
        let primaryService = LoaderStub(result: .success(primaryLessons))
        let fallbackService = LoaderStub(result: .success(fallbackLessons))
        let sut = LessonServiceWithLocakFallbackComposite(primary: primaryService, fallback: fallbackService)
        
        let exp = expectation(description: "Wait for load completion")
        sut.getLessons { result in
            switch result {
            case .success(let receivedLessons):
                XCTAssertEqual(receivedLessons, primaryLessons)
                
            case .failure:
                XCTFail("Expected successful load lessons result, got \(result) instead.")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    private func uniqueLessons() -> [Lesson] {
        return [
            Lesson(id: 1, name: "any name", description: "any description", thumbnail: URL(string: "http://any-image-url.com")!, videoUrl: URL(string: "http://any-video-url.com")!)
        ]
    }
    
    private class LoaderStub: LessonService {
        private let result: LessonService.Result
        
        init(result: LessonService.Result) {
            self.result = result
        }
        
        func getLessons(completion: @escaping (LessonService.Result) -> Void) {
            completion(result)
        }
    }
}
