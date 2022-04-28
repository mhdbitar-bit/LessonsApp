//
//  VideoDataStore.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/28/22.
//

import Foundation

protocol VideoDataStore {
    typealias RetrievalResult = Swift.Result<URL?, Error>
    typealias InsertionResult = Swift.Result<Void, Error>

    func insert(_ localURL: URL, for url: URL, completion: @escaping (InsertionResult) -> Void)
    func retrieve(forVideoURL url: URL, completion: @escaping (RetrievalResult) -> Void)
}
