//
//  LessonListViewModel.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/27/22.
//

import Foundation
import Combine

final class LessonListViewModel {
    
    let lessonService: LessonService
    let imageDataService: LessonImageDataService
    
    let title = "Lessons"
    @Published var lessons: [Lesson] = []
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    
    init(lessonService: LessonService, imageDataService: LessonImageDataService) {
        self.lessonService = lessonService
        self.imageDataService = imageDataService
    }
    
    func loadLessons() {
        isLoading = true
        lessonService.getLessons(completion: handleResponse)
    }
    
    private func handleResponse(_ result: Result<[Lesson], Error>) {
        isLoading = false
        switch result {
        case .success(let lessons):
            self.lessons = lessons
            
        case .failure(let error):
            self.error = error.localizedDescription
        }
    }
}
