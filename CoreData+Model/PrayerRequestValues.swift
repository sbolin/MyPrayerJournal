//
//  PrayerRequestValues.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 30-Oct-21.
//

import Foundation

// convenience, used for data tranlation...

struct PrayerRequestValues {
    let request: String
    let answered: Bool
    let dateRequested: Date
    let focused: Bool
    let id: UUID
    let lesson: String
    let notifiable: Bool
    let notifyTime: Date
    let statusID: Int16
    let topic: String
    let verseText: String
    let prayerTags: Set<PrayerTag>
    let prayerVerses: Set<PrayerVerse>
}
