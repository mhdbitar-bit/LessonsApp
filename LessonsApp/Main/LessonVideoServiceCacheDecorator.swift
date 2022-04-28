//
//  VideoServiceCacheDecorator.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/28/22.
//

import Foundation

final class LessonVideoServiceCacheDecorator: VideoDataService {
    private let decoratee: VideoDataService
    private let cache: VideoCache
    
    init(decoratee: VideoDataService, cache: VideoCache) {
        self.decoratee = decoratee
        self.cache = cache
    }
    
    func loadVideo(from url: URL, completion: @escaping (VideoDataService.Result) -> Void) {
        decoratee.loadVideo(from: url) { [weak self] result in
            completion(result.map { localURL in
                self?.cache.save(localURL, for: url) { _ in }
                return localURL
            })
        }
    }
}
