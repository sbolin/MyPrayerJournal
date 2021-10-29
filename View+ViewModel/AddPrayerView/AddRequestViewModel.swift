//
//  AddRequestViewModel.swift
//  AddRequestViewModel
//
//  Created by Scott Bolin on 8-Oct-21.
//

import CoreData
import SwiftUI

struct AddRequestViewModel {

    func isValidForm(prayerRequest: PrayerRequestValues) -> Bool {
        return prayerRequest.request.isEmpty
    }

    func fetchRequest(for objectID: NSManagedObjectID, context: NSManagedObjectContext) -> PrayerRequest? {
        guard let request = context.object(with: objectID) as? PrayerRequest else { return nil }
        return request
    }

    func savePrayer(requestID: NSManagedObjectID?, with requestValues: PrayerRequestValues, in context: NSManagedObjectContext) {
        let request: PrayerRequest
        if let objectID = requestID, let fetchedRequest = fetchRequest(for: objectID, context: context) {
            request = fetchedRequest
        } else {
            request = PrayerRequest(context: context)
        }
        request.request = requestValues.request
        request.topic = requestValues.topic
        request.lesson = requestValues.lesson
        request.dateRequested = requestValues.dateRequested
        request.focused = requestValues.focused

        if let tags = requestValues.prayerTags {
            tags.forEach { tag in
                request.prayerTag.insert(tag)
            }
        }
        if let verses = requestValues.prayerVerses {
            verses.forEach { verse in
                request.prayerVerse.insert(verse)
            }
        }
        CoreDataController.shared.save()
    }
}

/*
 let id = UUID()
 let answered: Bool
 let statusID: Int16
 let prayerTags: Set<TagValues>?
 let prayerVerses: Set<VerseValues>?
 */
