//
//  Verse+Ext.swift
//  MyPrayerJournal
//
//  Created by Scott Bolin on 17-Sep-21.
//

import CoreData

// not used, put in PrayerVerse+CoreDataProperties

/*
extension PrayerVerse {

    var bookIDString: String {
        return bookID ?? ""
    }

    var bookString: String {
        return book ?? ""
    }

    var chapterNumber: Int {
        guard let chapter = chapter else { return 0 }
        return Int(chapter) ?? 0
    }

    var endVerseNumber: Int {
        guard let endVerse = endVerse else { return 0 }
        return Int(endVerse) ?? 0
    }

    var startVerseNumber: Int {
        guard let startVerse = startVerse else { return 0}
        return Int(startVerse) ?? 0
    }

    @objc var verseTextString: String {
        return verseText ?? ""
    }

    var verseRequest: PrayerRequest {
        get { prayerRequest! }
        set { prayerRequest = newValue }
    }

    // create full verse name
    @objc var verseNameString: String {
        let bookIDText = bookID != nil ? "\(bookIDString) " : ""
        let endVerseText = endVerse != nil ? "-\(endVerseNumber)" : ""
        if bookString.isEmpty {
            return ""
        }
        return "\(bookIDText)\(bookString) \(chapterNumber):\(startVerseNumber)\(endVerseText)"
    }
}
*/
