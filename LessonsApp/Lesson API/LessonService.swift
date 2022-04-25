//
//  LessonService.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/25/22.
//

import Foundation

enum NetworkError: Error {
    case connectivity
    case invalidData
}

protocol LessonService {
    typealias Result = Swift.Result<[Lesson], Error>
    
    func getLessons(completion: @escaping (Result) -> Void)
}

final class RemoteLessonsService: LessonService {
    typealias Result = LessonService.Result
    
    private let url: URL
    private let client: HTTPClient
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func getLessons(completion: @escaping (Result) -> Void) {
        client.get(from: url) { result in
            switch result {
            case .success(let (data, response)):
                break
            case .failure:
                completion(.failure(NetworkError.connectivity))
            }
        }
    }
}
