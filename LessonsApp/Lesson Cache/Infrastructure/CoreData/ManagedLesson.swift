//
//  ManagedLesson.swift
//  LessonsApp
//
//  Created by Mohammad Bitar on 4/25/22.
//

import CoreData

@objc(ManagedLesson)
class ManagedLesson: NSManagedObject {
    @NSManaged var id: Int32
    @NSManaged var lessonDescription: String
    @NSManaged var thumbnailUrl: URL
    @NSManaged var videoUrl: URL
}

extension ManagedLesson {
    
}
