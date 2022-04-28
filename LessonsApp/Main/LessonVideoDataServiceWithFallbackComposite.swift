//
//  LessonVideoDataServiceWithFallbackComposite.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/28/22.
//

import Foundation

class LessonVideoDataServiceWithFallbackComposite: VideoDataService {
    private let primary: VideoDataService
    private let fallback: VideoDataService
    
    init(primary: VideoDataService, fallback: VideoDataService) {
        self.primary = primary
        self.fallback = fallback
    }
    
    func loadVideo(from url: URL, completion: @escaping (VideoDataService.Result) -> Void) {
        primary.loadVideo(from: url) { [weak self] result in
            switch result {
            case .success:
                completion(result)
            case .failure:
                self?.fallback.loadVideo(from: url, completion: completion)
            }
        }
    }
}
