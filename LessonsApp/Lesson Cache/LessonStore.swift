//
//  LessonStore.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/25/22.
//

import Foundation

protocol LessonStore {
    func deleteCachedLessons() throws
    func insert(_ lesson: Lesson) throws
    func retrieve() throws -> [Lesson]
}
