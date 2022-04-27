//
//  RemoteImageDataService.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/27/22.
//

import Foundation

final class RemoteImageDataService: LessonImageDataService {
    typealias Result = Swift.Result<Data, Error>
    
    private let client: HTTPClient
    
    public init(client: HTTPClient) {
        self.client = client
    }
    
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void) {
        client.get(from: url) { result in
            switch result {
            case let .success((data, response)):
                let isValidResponse = response.statusCode == 200 && !data.isEmpty
                completion(isValidResponse ? .success(data) : .failure(NetworkError.invalidData))
            case .failure:
                completion(.failure(NetworkError.connectivity))
            }
        }
    }
}
