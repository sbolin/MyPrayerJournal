//
//  PrayerRequest+Ext.swift
//  MyPrayerJournal
//
//  Created by Scott Bolin on 17-Sep-21.
//

import CoreData

extension PrayerRequest {

// set section date types
    var groupByMonth: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM yy" //"MMM yyyy"
            return dateFormatter.string(from: dateRequested ?? Date())
        }
    }

    var groupByWeek: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "'wk 'w ''yy"// "w Y"
            return dateFormatter.string(from: dateRequested ?? Date())
        }
    }

    var groupByDay: String {
        get {
            return dateFormatter.string(from: dateRequested ?? Date())
        }
    }

    // convert request to unwrapped string
    @objc var requestString: String {
        return request ?? "No Request"
    }

    // covert Bool to text representation
    @objc var answeredString: String {
        return answered ? "Answered Prayers" : "Unanswered Prayers"
    }

    // date in string format
    @objc var dateRequestedString: String {
        return dateFormatter.string(from: dateRequested ?? Date())
    }

    // unwrap topic
    @objc var topicString: String {
        return topic ?? "No Topic"
    }

    // unwrap staus
    @objc var statusString: String {
        switch statusID {
        case 0: return "Focused"
        case 1: return "Unanswered Prayers"
        case 2: return "Answered Prayers"
        default: return "Unanswered Prayers"
        }
    }

    @objc var verseTextString: String {
        return verseText ?? ""
    }

    @objc var requestTagString: String {
        return requestTag ?? ""
    }

    // set date format for sections...
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, y" // "MMMM d, yyyy"
        return formatter
    }

// set date to today if no date is set (shouldn't happen)
    var prayerDate: Date {
        get { dateRequested ?? Date() }
        set { dateRequested = newValue }
    }

// handle tags
    public var prayerTag: Set<PrayerTag> {
        get { prayerTags as? Set<PrayerTag> ?? [] }
        set { prayerTags = newValue as NSSet }
    }
// handle verses
    public var prayerVerse: Set<PrayerVerse> {
        get { prayerVerses as? Set<PrayerVerse> ?? [] }
        set { prayerVerses = newValue as NSSet }
    }


//    public var tagArray: [PrayerTag] {
//        let set = prayerTags as? Set<PrayerTag> ?? []
//        return set.sorted {
//            $0.tagNameString < $1.tagNameString
//        }
//    }
//
//    public var verseArray: [PrayerVerse] {
//        let set = prayerVerses as? Set<PrayerVerse> ?? []
//        return set.sorted {
//            $0.verseNameString < $1.verseNameString
//        }
//    }
}
