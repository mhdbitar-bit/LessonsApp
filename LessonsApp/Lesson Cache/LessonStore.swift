//
//  LessonStore.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/25/22.
//

import Foundation

protocol LessonStore {
    typealias DeletionResult = Result<Void, Error>
    typealias InsertionResult = Result<Void, Error>
    typealias RetrievalResult = Result<[Lesson], Error>
    
    func deleteCachedLessons(completion: @escaping (DeletionResult) -> Void)
    func insert(_ lesson: Lesson, completion: @escaping (InsertionResult) -> Void)
    func retrieve(completion: @escaping (RetrievalResult) -> Void)
}
