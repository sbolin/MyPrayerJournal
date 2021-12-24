//
//  AddRequestViewModel.swift
//  AddRequestViewModel
//
//  Created by Scott Bolin on 8-Oct-21.
//

import CoreData
import SwiftUI
import WidgetKit

struct AddRequestViewModel {
    let coreDataManager: CoreDataController = .shared

    func fetchPrayer(for objectID: NSManagedObjectID, context: NSManagedObjectContext) -> PrayerRequest? {
        guard let request = context.object(with: objectID) as? PrayerRequest else { return nil }
        return request
    }

    func savePrayer(requestID: NSManagedObjectID?, with requestValues: PrayerRequestValues, in context: NSManagedObjectContext) {
        let request: PrayerRequest
        if let objectID = requestID, let fetchedRequest = fetchPrayer(for: objectID, context: context) {
            request = fetchedRequest
            print("fetched existing request to update")
        } else {
            request = PrayerRequest(context: context)
            print("created new request to save")
        }
        request.request = requestValues.request
        request.answered = requestValues.answered
        request.dateRequested = requestValues.dateRequested
        request.focused = requestValues.focused
        request.id = requestValues.id
        request.lesson = requestValues.lesson
        request.statusID = requestValues.statusID
        request.topic = requestValues.topic
        request.verseText = requestValues.verseText
        request.requestTag = requestValues.requestTag

        let tags = requestValues.prayerTags
        tags.forEach { tag in
            request.addToPrayerTags(tag)
        }

        let verses = requestValues.prayerVerses
        verses.forEach { verse in
            request.addToPrayerVerses(verse)
        }

//        coreDataManager.save()

        if context.hasChanges {
            do {
                try context.save()
                WidgetCenter.shared.reloadAllTimelines()
            } catch {
                print("Error saving prayer request: \(error.localizedDescription)")
            }
        }
    }
}

