//
//  LessonMapper.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/25/22.
//

import Foundation

final class LessonMapper {
    private struct LessonResponse: Decodable {
        private let lessons: [LessonItem]
    
        private struct LessonItem: Decodable {
            let id: Int
            let name: String
            let description: String
            let thumbnail: URL
            let video_url: URL
        }
        
        var items: [Lesson] {
            lessons.map { Lesson(
                id: $0.id,
                name: $0.name,
                description: $0.description,
                thumbnail: $0.thumbnail,
                videoUrl: $0.video_url
            )}
        }
    }
}
