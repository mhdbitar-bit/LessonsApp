//
//  URLSessionHTTPClient.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/25/22.
//

import Foundation

protocol HTTPClient {
    func get(from url: URL, completion: @escaping (Result<(data: Data, response: HTTPURLResponse), Error>) -> Void)
}

final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    private struct UnexpectedValuesRepresentation: Error {}
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get(from url: URL, completion: @escaping (Result<(data: Data, response: HTTPURLResponse), Error>) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedValuesRepresentation()
                }
            })
        }
        task.resume()
    }
}
