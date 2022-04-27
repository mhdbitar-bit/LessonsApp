//
//  LocalLessonService.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/25/22.
//

import Foundation

enum CacheError: Error {
    case noData
}

protocol LessonCache {
    func save(_ lesson: Lesson) throws
}

final class LocalLessonService {
    private let store: LessonStore
    
    init(store: LessonStore) {
        self.store = store
    }
}

extension LocalLessonService: LessonCache {
    func save(_ lesson: Lesson) throws {
        try store.deleteCachedLessons()
        try store.insert(lesson)
    }
}

extension LocalLessonService: LessonService {
    typealias Result = LessonService.Result
    
    func getLessons(completion: @escaping (Result) -> Void) {
        do {
            completion(.success(try store.retrieve()))
        } catch {
            completion(.failure(CacheError.noData))
        }
    }
}
