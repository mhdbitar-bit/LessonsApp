//
//  LocaleVideoDataService.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/28/22.
//

import Foundation

protocol VideoCache {
    typealias SaveResult = Result<Void, Error>
    
    func save(_ localURL: URL, for url: URL, completion: @escaping (SaveResult) -> Void)
}

final class LocaleVideoDataService: VideoDataService {
    typealias LoadResult = VideoDataService.Result
    private let store: VideoDataStore
    
    init(store: VideoDataStore) {
        self.store = store
    }
    
    func loadVideo(from url: URL, completion: @escaping (VideoDataService.Result) -> Void) {
        store.retrieve(forVideoURL: url) { result in
            switch result {
            case let .success(storedUrl):
                if let storedUrl = storedUrl {
                    completion(.success(storedUrl))
                } else {
                    completion(.failure(CacheError.noData))
                }
            case .failure:
                completion(.failure(CacheError.failed))
            }
        }
    }
}

extension LocaleVideoDataService: VideoCache {
    func save(_ localURL: URL, for url: URL, completion: @escaping (VideoCache.SaveResult) -> Void) {
        store.insert(localURL, for: url) { result in
            switch result {
            case .failure:
                completion(.failure(CacheError.failed))
            default: break
            }
        }
    }
}
