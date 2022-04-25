//
//  LessonEndpoint.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/25/22.
//

import Foundation

enum LessonEndpoint {
    case getLessons
    
    func url(baseURL: URL) -> URL {
        switch self {
        case .getLessons:
            var components = URLComponents()
            components.scheme = baseURL.scheme
            components.host = baseURL.host
            components.path = baseURL.path + "test-api/lessons"
            components.queryItems = []
            return components
        }
    }
}
