//
//  LessonSerivce.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/27/22.
//

import Foundation

protocol LessonService {
    typealias Result = Swift.Result<[Lesson], Error>
    
    func getLessons(completion: @escaping (Result) -> Void)
}
