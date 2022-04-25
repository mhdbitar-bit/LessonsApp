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
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Lesson] {
        guard response.statusCode == 200, let lessons = try? JSONDecoder().decode(LessonResponse.self, from: data) else {
            throw NetworkError.invalidData
        }
        
        return lessons.items
    }
}
