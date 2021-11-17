//
//  AddRequestViewModel.swift
//  AddRequestViewModel
//
//  Created by Scott Bolin on 8-Oct-21.
//

import CoreData
import SwiftUI

struct AddRequestViewModel {

    func fetchPrayer(for objectID: NSManagedObjectID, context: NSManagedObjectContext) -> PrayerRequest? {
        guard let request = context.object(with: objectID) as? PrayerRequest else { return nil }
        return request
    }

    func savePrayer(requestID: NSManagedObjectID?, with requestValues: PrayerRequestValues, in context: NSManagedObjectContext) {
        let request: PrayerRequest
        if let objectID = requestID, let fetchedRequest = fetchPrayer(for: objectID, context: context) {
            request = fetchedRequest
        } else {
            request = PrayerRequest(context: context)
        }
        request.request = requestValues.request
        request.answered = requestValues.answered
        request.dateRequested = requestValues.dateRequested
        request.focused = requestValues.focused
        request.lesson = requestValues.lesson
        request.statusID = requestValues.statusID
        request.topic = requestValues.topic
        request.verseText = requestValues.verseText
        request.requestTag = requestValues.requestTag

        let tags = requestValues.prayerTags
        tags.forEach { tag in
            request.prayerTag.insert(tag)
        }

        let verses = requestValues.prayerVerses
        verses.forEach { verse in
            request.prayerVerse.insert(verse)
        }

        do {
            try context.save()
        } catch {
            print("Save error: \(error)")
        }
    }
}

