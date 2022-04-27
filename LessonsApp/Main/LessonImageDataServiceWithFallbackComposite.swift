//
//  LessonImageDataServiceWithFallbackComposite.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/27/22.
//

import Foundation

class LessonImageDataServiceWithFallbackComposite: LessonImageDataService {
    private let primary: LessonImageDataService
    private let fallback: LessonImageDataService
    
    init(primary: LessonImageDataService, fallback: LessonImageDataService) {
        self.primary = primary
        self.fallback = fallback
    }
    
    func loadImageData(from url: URL, completion: @escaping (LessonImageDataService.Result) -> Void) {
        primary.loadImageData(from: url) { [weak self] result in
            switch result {
            case .success:
                completion(result)
            case .failure:
                self?.fallback.loadImageData(from: url, completion: completion)
            }
        }
    }
}
