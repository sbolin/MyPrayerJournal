//
//  Verse+Ext.swift
//  MyPrayerJournal
//
//  Created by Scott Bolin on 17-Sep-21.
//

import CoreData

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

    var verseTextString: String {
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
        return "\(bookIDText)\(bookString) \(chapterNumber):\(startVerseNumber)\(endVerseText)"
    }

//    static var fetchAllVersesByRequest: NSFetchRequest<PrayerVerse> {
//        let request: NSFetchRequest<PrayerVerse> = PrayerVerse.fetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(keyPath: \PrayerVerse.prayerRequest, ascending: true)]
//        return request
//    }
}

/*
 @NSManaged public var book: String?
 @NSManaged public var chapter: Int16
 @NSManaged public var endVerse: Int16
 @NSManaged public var startVerse: Int16
 @NSManaged public var verseText: String?
 @NSManaged public var request: PrayerRequest?
 */


// relationship
// request -> PrayerRequest
