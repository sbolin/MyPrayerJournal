//
//  VerseValues.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 30-Oct-21.
//

import Foundation

struct VerseValues: Hashable {
    let id = UUID()
    let book: String?
    let bookID: String?
    let chapter: String?
    let endVerse: String?
    let startVerse: String?
    let verseText: String?
    let prayerRequest: PrayerRequestValues?

    func hash(into hasher: inout Hasher) {
        hasher.combine(book)
        hasher.combine(bookID)
    }

    static func == (lhs: VerseValues, rhs: VerseValues) -> Bool {
        lhs.book == rhs.book
    }
}
