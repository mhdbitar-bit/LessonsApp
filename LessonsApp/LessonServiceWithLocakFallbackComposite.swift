//
//  LessonServiceWithLocakFallbackComposite.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/27/22.
//

import Foundation

class LessonServiceWithLocakFallbackComposite: LessonService {
    private let primary: LessonService
    private let fallback: LessonService
    
    init(primary: LessonService, fallback: LessonService) {
        self.primary = primary
        self.fallback = fallback
    }
    
    func getLessons(completion: @escaping (LessonService.Result) -> Void) {
        primary.getLessons { [weak self] result in
            switch result {
            case .success:
                completion(result)
            case .failure:
                self?.fallback.getLessons(completion: completion)
            }
        }
    }
}
