//
//  PrayerVerse+CoreDataProperties.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 1-Dec-21.
//
//

import Foundation
import CoreData


extension PrayerVerse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PrayerVerse> {
        return NSFetchRequest<PrayerVerse>(entityName: "PrayerVerse")
    }

    @NSManaged public var book: String?
    @NSManaged public var bookID: String?
    @NSManaged public var chapter: String?
    @NSManaged public var endVerse: String?
    @NSManaged public var id: UUID?
    @NSManaged public var startVerse: String?
    @NSManaged public var verseText: String?
    @NSManaged public var prayerRequest: PrayerRequest?

    var bookString: String {
        return book ?? ""
    }

    var bookIDString: String {
        return bookID ?? ""
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

extension PrayerVerse : Identifiable {

}
