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

protocol HTTPDownloadClient {
    func download(from url: URL, completion: @escaping (Result<(url: URL, response: HTTPURLResponse), Error>) -> Void)
}

final class URLSessionHTTPClient: NSObject, HTTPClient {
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

extension URLSessionHTTPClient: HTTPDownloadClient {
    func download(from url: URL, completion: @escaping (Result<(url: URL, response: HTTPURLResponse), Error>) -> Void) {
        let task = session.downloadTask(with: url) { resultURL, response, error in
            completion(Result {
                if let error = error {
                    throw error
                } else if let resultURL = resultURL, let response = response as? HTTPURLResponse {
                    return (resultURL, response)
                } else {
                    throw UnexpectedValuesRepresentation()
                }
            })
        }
        task.resume()
    }
}
