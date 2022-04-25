//
//  LocalLessonLoader.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/25/22.
//

import Foundation

protocol LessonCache {
    func save(_ lesson: Lesson) throws
}

final class LocalLessonLoader {
    private let store: LessonStore
    
    init(store: LessonStore) {
        self.store = store
    }
}

extension LocalLessonLoader: LessonCache {
    func save(_ lesson: Lesson) throws {
        try store.deleteCachedLessons()
        try store.insert(lesson)
    }
}

extension LocalLessonLoader {
    func load() throws -> [Lesson] {
        return try store.retrieve()
    }
}
