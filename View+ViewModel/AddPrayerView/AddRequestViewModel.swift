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
        request.notifiable = requestValues.notifiable
        request.notifyTime = requestValues.notifyTime

        let tags = requestValues.prayerTags
        print("saving \(tags.count) prayer tags")
        tags.forEach { tag in
            tag.id = UUID()
            tag.prayerRequest = request
            request.addToPrayerTags(tag)
        }

        coreDataManager.save()

// TODO: Need to develop verse functionality further before implementing.
//        let verses = requestValues.prayerVerses
//        print("saving \(verses.count) prayer verses")
//        verses.forEach { verse in
//            print("saving verse: \(verse.verseText ?? "No verse!")")
//            request.addToPrayerVerses(verse)
//            print("number of verses in request(Set): \(request.prayerVerse.count)")
//            print("number of verses in request(NSSet: \(request.prayerVerses?.count ?? 0)")
//
//        }
    }
}

