//
//  LessonServiceWithLocakFallbackCompositeTests.swift
//  LessonsAppTests
//
//  Created by Mohammad Bitar on 4/25/22.
//

import XCTest
@testable import LessonsApp

class LessonServiceWithLocakFallbackCompositeTests: XCTestCase {

    func test_load_deliversPrimaryLessonsOnPrimarySuccess() {
        let primaryLessons = uniqueLessons()
        let fallbackLessons = uniqueLessons()
        let sut = makeSUT(primaryResult: .success(primaryLessons), fallbackResult: .success(fallbackLessons))
        expect(sut, toCompleteWith: .success(primaryLessons))
    }
    
    func test_load_deliversFallbackOnPrimaryFailure() {
        let fallbackLessons = uniqueLessons()
        let sut = makeSUT(primaryResult: .failure(anyNSError()), fallbackResult: .success(fallbackLessons))
        expect(sut, toCompleteWith: .success(fallbackLessons))
    }
    
    func test_load_deliversErrorOnBothPrimaryAndFallbackServiceFailure() {
        let sut = makeSUT(primaryResult: .failure(anyNSError()), fallbackResult: .failure(anyNSError()))
        expect(sut, toCompleteWith: .failure(anyNSError()))
    }
    
    // MARK: - Helpers
    
    private func makeSUT(primaryResult: LessonService.Result, fallbackResult: LessonService.Result, file: StaticString = #file, line: UInt = #line) -> LessonService {
        let primaryService = LoaderStub(result: primaryResult)
        let fallbackService = LoaderStub(result: fallbackResult)
        let sut = LessonServiceWithFallbackComposite(primary: primaryService, fallback: fallbackService)
        trackForMemoryLeaks(primaryService, file: file, line: line)
        trackForMemoryLeaks(fallbackService, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func expect(_ sut: LessonService, toCompleteWith expectedResult: LessonService.Result, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")
        sut.getLessons { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedLessons), .success(expectedLessons)):
                XCTAssertEqual(receivedLessons, expectedLessons, file: file, line: line)
                
            case (.failure, .failure):
                break
                
            default:
                XCTFail("Expected \(expectedResult), got \(receivedResult) instead.")
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
