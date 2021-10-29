//
//  PrayerRequestValues.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 30-Oct-21.
//

import Foundation

struct PrayerRequestValues {
    let id = UUID()
    let request: String
    let answered: Bool
    let dateRequested: Date
    let focused: Bool
    let lesson: String?
    let statusID: Int16
    let topic: String?
    let prayerTags: Set<PrayerTag>?
    let prayerVerses: Set<PrayerVerse>?
}
