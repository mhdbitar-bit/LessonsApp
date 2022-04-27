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
    private let fallback: LessonService
    
    init(primary: LessonService, fallback: LessonService) {
        self.primary = primary
        self.fallback = fallback
    }
    
    func getLessons(completion: @escaping (LessonService.Result) -> Void) {
        primary.getLessons { [weak self] result in
            switch result {
            case .success:
                completion(result)
            case .failure:
                self?.fallback.getLessons(completion: completion)
            }
        }
    }
}

class LessonServiceWithLocakFallbackCompositeTests: XCTestCase {

    func test_load_deliversPrimaryLessonsOnPrimarySuccess() {
        let primaryLessons = uniqueLessons()
        let fallbackLessons = uniqueLessons()
        let sut = makeSUT(primaryResult: .success(primaryLessons), fallbackResult: .success(fallbackLessons))
        
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
    
    func test_load_deliversFallbackOnPrimaryFailure() {
        let fallbackLessons = uniqueLessons()
        let sut = makeSUT(primaryResult: .failure(anyNSError()), fallbackResult: .success(fallbackLessons))
        
        let exp = expectation(description: "Wait for load completion")
        sut.getLessons { result in
            switch result {
            case .success(let receivedLessons):
                XCTAssertEqual(receivedLessons, fallbackLessons)
                
            case .failure:
                XCTFail("Expected successful load lessons result, got \(result) instead.")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(primaryResult: LessonService.Result, fallbackResult: LessonService.Result, file: StaticString = #file, line: UInt = #line) -> LessonService {
        let primaryService = LoaderStub(result: primaryResult)
        let fallbackService = LoaderStub(result: fallbackResult)
        let sut = LessonServiceWithLocakFallbackComposite(primary: primaryService, fallback: fallbackService)
        trackForMemoryLeaks(primaryService, file: file, line: line)
        trackForMemoryLeaks(fallbackService, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func uniqueLessons() -> [Lesson] {
        return [
            Lesson(id: 1, name: "any name", description: "any description", thumbnail: URL(string: "http://any-image-url.com")!, videoUrl: URL(string: "http://any-video-url.com")!)
        ]
    }
    
    private func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
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
