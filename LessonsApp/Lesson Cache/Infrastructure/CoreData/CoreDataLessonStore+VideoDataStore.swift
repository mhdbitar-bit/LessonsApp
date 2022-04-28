//
//  CoreDataLessonStore+VideoDataStore.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/28/22.
//

import Foundation

extension CoreDataLessonStore: VideoDataStore {
    
    func retrieve(forVideoURL url: URL, completion: @escaping (VideoDataStore.RetrievalResult) -> Void) {
        perform { context in
            completion(Result {
                try ManagedLesson.find(videoUrl: url, in: context)?.downloadedVideoUrl
            })
        }
    }
    
    func insert(_ localURL: URL, for url: URL, completion: @escaping (VideoDataStore.InsertionResult) -> Void) {
        perform { context in
            completion(Result {
                let managedLesson = try ManagedLesson.find(videoUrl: localURL, in: context)
                managedLesson?.downloadedVideoUrl = localURL
                try context.save()
            })
        }
    }
}
