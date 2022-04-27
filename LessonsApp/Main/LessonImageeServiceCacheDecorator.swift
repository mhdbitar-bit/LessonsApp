//
//  LessonImageeServiceCacheDecorator.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/27/22.
//

import Foundation

final class LessonImageeServiceCacheDecorator: LessonImageDataService {
    private let decoratee: LessonImageDataService
    private let cache: ImageCache
    
    init(decoratee: LessonImageDataService, cache: ImageCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    func loadImageData(from url: URL, completion: @escaping (LessonImageDataService.Result) -> Void) {
        decoratee.loadImageData(from: url) { [weak self] result in
            completion(result.map { data in
                self?.cache.save(data, for: url) { _ in }
                return data
            })
        }
    }
}
