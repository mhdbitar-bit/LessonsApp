//
//  CoreDataLessonStore+ImadeDataStore.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/27/22.
//

import Foundation

extension CoreDataLessonStore: ImadeDataStore {
    
    func retrieve(dataForURL url: URL, completion: @escaping (ImadeDataStore.RetrievalResult) -> Void) {
        perform { context in
            completion(Result {
                try ManagedLesson.find(where: url, in: context)?.imageData
            })
        }
    }
    
    func insert(_ data: Data, for url: URL, completion: @escaping (ImadeDataStore.InsertionResult) -> Void) {
        perform { context in
            completion(Result {
                let managedLesson = try ManagedLesson.find(where: url, in: context)
                managedLesson?.imageData = data
                try context.save()
            })
        }
    }
}
