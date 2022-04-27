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
    @NSManaged var name: String
    @NSManaged var lessonDescription: String
    @NSManaged var thumbnailUrl: URL
    @NSManaged var videoUrl: URL
    @NSManaged var imageData: Data?
}

extension ManagedLesson {
    static func find(in context: NSManagedObjectContext) throws -> ManagedLesson? {
        let request = NSFetchRequest<ManagedLesson>(entityName: entity().name!)
        request.returnsObjectsAsFaults = false
        return try context.fetch(request).first
    }
    
    static func find(where url: URL, in context: NSManagedObjectContext) throws -> ManagedLesson? {
        let request = NSFetchRequest<ManagedLesson>(entityName: entity().name!)
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(ManagedLesson.thumbnailUrl), url])
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 1
        return try context.fetch(request).first
    }
    
    static func lessons(in context: NSManagedObjectContext) throws -> [ManagedLesson] {
        let request = NSFetchRequest<ManagedLesson>(entityName: entity().name!)
        request.returnsObjectsAsFaults = false
        return try context.fetch(request)
    }
    
    static func deleteCache(in context: NSManagedObjectContext) throws {
        try find(in: context).map(context.delete).map(context.save)
    }
    
    static func newUniqueInstance(in context: NSManagedObjectContext) throws -> ManagedLesson {
        try deleteCache(in: context)
        return ManagedLesson(context: context)
    }
}
