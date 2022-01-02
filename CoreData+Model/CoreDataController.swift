//
//  CoreDataController.swift
//  PersistenceController
//
//  Created by Scott Bolin on 6-Sep-21.
//

import SwiftUI
import CoreData
import WidgetKit

class CoreDataController {
    // Singleton for whole app to use
    static let shared = CoreDataController()

    private let inMemory: Bool
    private init(inMemory: Bool = false) {
        self.inMemory = inMemory
        ValueTransformer.setValueTransformer(ColorValueTransformer(), forName: NSValueTransformerName("ColorValueTransformer"))
    }

    lazy var container: NSPersistentContainer = {
        let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.io.tukgaesoft.MyPrayerJournal")!.appendingPathComponent("MyPrayers.sqlite")

        let container = NSPersistentContainer(name: "MyPrayers")
        container.persistentStoreDescriptions = [NSPersistentStoreDescription(url: containerURL)]

//        guard let description = container.persistentStoreDescriptions.first else {
//            fatalError("Failed to retrieve a persistent store description")
//        }
//
//        if inMemory {
//            description.url = URL(fileURLWithPath: "/dev/null")
//        }

        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        return container
    }()

    var context: NSManagedObjectContext {
        return container.viewContext
    }

    var workingContext: NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = context
        return context
    }

    // utility functions
    func save() {
        if context.hasChanges {
            do {
                try context.save()
                WidgetCenter.shared.reloadAllTimelines()
            } catch {
                // throw error
                print("Could not save, \(error.localizedDescription)")
            }
        }
    }

    func updatePrayerCompletion(request: PrayerRequest, isCompleted: Bool, context: NSManagedObjectContext) {
        request.answered = !isCompleted
        save()
//        do {
//            try context.save()
//        } catch {
//            // throw error
//            print("Could not save, \(error.localizedDescription)")
//        }
    }

    func deleteRequest(request: PrayerRequest, context: NSManagedObjectContext) {
        context.delete(request)
        save()
    }

    func deleteItem(for indexSet: IndexSet, section: SectionedFetchResults<String, PrayerRequest>.Element, viewContext: NSManagedObjectContext) {
        indexSet.map { section[$0] }.forEach(viewContext.delete)
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

