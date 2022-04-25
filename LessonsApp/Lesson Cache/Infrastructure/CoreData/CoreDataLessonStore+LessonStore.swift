//
//  CoreDataLessonStore+LessonStore.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/25/22.
//

import CoreData

extension CoreDataLessonStore: LessonStore {
    
    func deleteCachedLessons() throws {
        try performSync { context in
            Result {
                try ManagedLesson.deleteCache(in: context)
            }
        }
    }
    
    func insert(_ lesson: Lesson) throws {
        try performSync { context in
            Result {
                let managedLesson = try ManagedLesson.newUniqueInstance(in: context)
                managedLesson.id = Int32(lesson.id)
                managedLesson.name = lesson.name
                managedLesson.lessonDescription = lesson.description
                managedLesson.thumbnailUrl = lesson.thumbnail
                managedLesson.videoUrl = lesson.videoUrl
                try context.save()
            }
        }
    }
    
    func retrieve() throws -> [Lesson] {
        try performSync { context in
            Result {
                try ManagedLesson.lessons(in: context).map {
                    Lesson(
                        id: Int($0.id),
                        name: $0.name,
                        description: $0.lessonDescription,
                        thumbnail: $0.thumbnailUrl,
                        videoUrl: $0.videoUrl)
                }
            }
        }
    }
}
