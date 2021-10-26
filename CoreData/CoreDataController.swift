//
//  CoreDataController.swift
//  PersistenceController
//
//  Created by Scott Bolin on 6-Sep-21.
//

import CoreData

struct CoreDataController {
    // Singleton for whole app to use
    static let shared = CoreDataController()

    // Storage for Core Data
    let container: NSPersistentContainer

    // Convenience
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    static var preview: CoreDataController = {
        let result = CoreDataController(inMemory: true)
        let viewContext = result.container.viewContext

        let calendar = Calendar.current
        let newItem = PrayerRequest(context: viewContext)
        let newTag = PrayerTag(context: viewContext)
        let newVerse = PrayerVerse(context: viewContext)
        let date = Date()
        newItem.prayer = "Prayer Request"
        newItem.topic = "Prayer Topic"
        newItem.dateRequested = date
        newItem.lesson = "Lesson learned"
        newItem.answered = Bool.random()
        newTag.tagName = "Tag"
        newTag.prayerRequest = newItem
        newVerse.book = "John"
        newVerse.chapter = "3"
        newVerse.startVerse = "16"
        newVerse.verseText = "For God so loved the world that he gave his only Son, that whoever believes in him should not perish but have eternal life."
        newVerse.prayerRequest = newItem
        shared.save()

        return result
    }()

    // Initializer to load Core Data,optionally able to use in-memory for testing
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MyPrayers")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize Core Data Stores. Good Bye. \(error.localizedDescription)")
            }
        }
//        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    // utility functions
    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // throw error
                print("Could not save, \(error.localizedDescription)")
            }
        }
    }

    func updatePrayerCompletion(request: PrayerRequest, isCompleted: Bool) {
        request.answered = isCompleted
        save()
    }

    func deleteRequest(request: PrayerRequest) {
        CoreDataController.shared.container.viewContext.delete(request)
        save()
    }

}

extension CoreDataController {

// fetch all Tags in PrayerRequest
    func fetchTags(for prayerRequest: PrayerRequest) -> [PrayerTag]? {
        let request: NSFetchRequest<PrayerTag> = PrayerTag.fetchRequest()
        let predicate = NSPredicate(format: "%K == %@", #keyPath(PrayerTag.prayerRequest.objectID), prayerRequest.objectID)
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(keyPath: \PrayerTag.tagName, ascending: true)]

        do {
            return try CoreDataController.shared.container.viewContext.fetch(request)
        } catch {
            return []
        }
    }

// fetch all Verses in PrayerRequest
    func fetchVerses(for prayerRequest: PrayerRequest) -> [PrayerVerse]? {
        let request: NSFetchRequest<PrayerVerse> = PrayerVerse.fetchRequest()
        let predicate = NSPredicate(format: "%K == %@", #keyPath(PrayerVerse.prayerRequest.objectID), prayerRequest.objectID)
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(keyPath: \PrayerVerse.bookString, ascending: true)]

        do {
            return try CoreDataController.shared.container.viewContext.fetch(request)
        } catch {
            return []
        }
    }

// PrayerRequest by ID
    func getPrayerById(id: NSManagedObjectID) -> PrayerRequest? {
        do {
            return try CoreDataController.shared.container.viewContext.existingObject(with: id) as? PrayerRequest
        } catch {
            return nil
        }
    }

// Tag by ID
    func getTagById(id: NSManagedObjectID) -> PrayerTag? {
        do {
            return try CoreDataController.shared.container.viewContext.existingObject(with: id) as? PrayerTag
        } catch {
            return nil
        }
    }

// Verse by ID
    func getVerseById(id: NSManagedObjectID) -> PrayerVerse? {
        do {
            return try CoreDataController.shared.container.viewContext.existingObject(with: id) as? PrayerVerse
        } catch {
            return nil
        }
    }


}

