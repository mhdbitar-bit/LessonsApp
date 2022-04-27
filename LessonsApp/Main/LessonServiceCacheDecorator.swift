//
//  LessonServiceCacheDecorator.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/27/22.
//

import Foundation

final class LessonServiceCacheDecorator: LessonService {
    private let decoratee: LessonService
    private let cache: LessonCache
    
    init(decoratee: LessonService, cache: LessonCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    func getLessons(completion: @escaping (LessonService.Result) -> Void) {
        decoratee.getLessons { [weak self] result in
            completion(result.map { lessons in
                self?.cache.save(lessons) { _ in }
                return lessons
            })
        }
    }
}
