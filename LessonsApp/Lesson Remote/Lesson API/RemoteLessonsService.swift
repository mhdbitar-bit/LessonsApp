//
//  RemoteLessonsService.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/25/22.
//

import Foundation

enum NetworkError: Error {
    case connectivity
    case invalidData
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
                completion(RemoteLessonsService.map(data, from: response))
            case .failure:
                completion(.failure(NetworkError.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let lessons = try LessonMapper.map(data, from: response)
            return .success(lessons)
        } catch {
            return .failure(error)
        }
    }
}
