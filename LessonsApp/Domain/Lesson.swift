//
//  Lesson.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/25/22.
//

import Foundation

struct Lesson: Equatable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: URL
    let videoUrl: URL
}
