//
//  LocalLessonService.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/25/22.
//

import Foundation

enum CacheError: Error {
    case noData
    case failed
}

protocol LessonCache {
    typealias SaveResult = Result<Void, Error>
    
    func save(_ lessons: [Lesson], completion: @escaping (SaveResult) -> Void)
}

final class LocalLessonService {
    private let store: LessonStore
    
    init(store: LessonStore) {
        self.store = store
    }
}

extension LocalLessonService: LessonCache {
    
    func save(_ lessons: [Lesson], completion: @escaping (SaveResult) -> Void) {
        store.deleteCachedLessons { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.storeLesson(lessons, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func storeLesson(_ lessons: [Lesson], completion: @escaping (SaveResult) -> Void) {
        lessons.forEach { lesson in
            self.store.insert(lesson, completion: completion)
        }
    }
}

extension LocalLessonService: LessonService {
    func getLessons(completion: @escaping (LessonService.Result) -> Void) {
        store.retrieve { result in
            switch result {
            case .success(let lessons):
                completion(.success(lessons))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
