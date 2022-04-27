//
//  LocaleImageDataService.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/27/22.
//

import Foundation

protocol ImageCache {
    typealias SaveResult = Result<Void, Error>
    
    func save(_ data: Data, for url: URL, completion: @escaping (SaveResult) -> Void)
}

final class LocaleImageDataService: LessonImageDataService {
    typealias LoadResut = LessonImageDataService.Result
    private let store: ImadeDataStore
    
    
    init(store: ImadeDataStore) {
        self.store = store
    }
    
    func loadImageData(from url: URL, completion: @escaping (LoadResut) -> Void) {
        store.retrieve(dataForURL: url, completion: { result in
            switch result {
            case let .success(data):
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(CacheError.noData))
                }
            case .failure:
                completion(.failure(CacheError.failed))
            }
        })
    }
}

extension LocaleImageDataService: ImageCache {
    func save(_ data: Data, for url: URL, completion: @escaping (ImageCache.SaveResult) -> Void) {
        store.insert(data, for: url) { result in
            switch result {
            case .failure:
                completion(.failure(CacheError.failed))
            default: break
            }
        }
    }
}
