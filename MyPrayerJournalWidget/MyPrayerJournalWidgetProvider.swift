//
//  MyPrayerJournalWidgetProvider.swift
//  MyPrayerJournalWidgetExtension
//
//  Created by Scott Bolin on 3-Mar-22.
//

import CoreData
import SwiftUI
import WidgetKit

struct MyPrayerJournalWidgetProvider: TimelineProvider {

    let snapshotEntry = MyPrayerJournalWidgetEntry(date: Date(), request: "A Prayer Request", dateRequested: Date().addingTimeInterval(-1 * 60 * 60 * 24), topic: "A Prayer Topic", answered: false, statusID: 1)

    func placeholder(in context: Context) -> MyPrayerJournalWidgetEntry {
        return snapshotEntry
    }

    func getSnapshot(in context: Context, completion: @escaping (MyPrayerJournalWidgetEntry) -> ()) {
        return completion(snapshotEntry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MyPrayerJournalWidgetEntry>) -> ()) {
        var entries: [MyPrayerJournalWidgetEntry] = []

        // get core data
        let moc = CoreDataController.shared.container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PrayerRequest")
        var results = [PrayerRequest]()

        do {
            results = try moc.fetch(request) as! [PrayerRequest]
        } catch {
            print("Could not fetch \(error.localizedDescription)")
        }

        let focusItems = results.filter { $0.focused == true }
        guard let focusItem = focusItems.first else { return }

        let prayerRequest = focusItem.request
        let dateRequested = focusItem.dateRequested
        let topic = focusItem.topic
        let lesson = focusItem.lesson
        let answered = focusItem.answered
        let statusID = focusItem.statusID

        let entry = MyPrayerJournalWidgetEntry(date: Date(), request: prayerRequest, dateRequested: dateRequested, topic: topic, lesson: lesson, answered: answered, statusID: statusID)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}
