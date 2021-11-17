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
    var prayerTag: Set<PrayerTag> {
        get { prayerTags as? Set<PrayerTag> ?? [] }
        set { prayerTags = newValue as NSSet }
    }
// handle verses
    var prayerVerse: Set<PrayerVerse> {
        get { prayerVerses as? Set<PrayerVerse> ?? [] }
        set { prayerVerses = newValue as NSSet }
    }

    // PrayerRequest NSFetchRequest
//    static var fetchAllRequestsByDate: NSFetchRequest<PrayerRequest> {
//        let request: NSFetchRequest<PrayerRequest> = PrayerRequest.fetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(keyPath: \PrayerRequest.dateRequested, ascending: true)]
//        return request
//    }

/*
    static var fetchAllRequests: NSFetchRequest<PrayerRequest> {
        let request: NSFetchRequest<PrayerRequest> = PrayerRequest.fetchRequest()
        return request
    }



    static var fetchAnswered: NSFetchRequest<PrayerRequest> {
        let request: NSFetchRequest<PrayerRequest> = PrayerRequest.fetchRequest()
        let predicate = NSPredicate(format: "%K == %@", #keyPath(PrayerRequest.answered), NSNumber(value: true))
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(keyPath: \PrayerRequest.dateRequested, ascending: true)]
        return request
    }

    static var fetchUnAnswered: NSFetchRequest<PrayerRequest> {
        let request: NSFetchRequest<PrayerRequest> = PrayerRequest.fetchRequest()
        let predicate = NSPredicate(format: "%K == %@", #keyPath(PrayerRequest.answered), NSNumber(value: false))
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(keyPath: \PrayerRequest.dateRequested, ascending: true)]
        return request
    }

    static var fetchAnwserSortedRequests: NSFetchRequest<PrayerRequest> {
        let request: NSFetchRequest<PrayerRequest> = PrayerRequest.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \PrayerRequest.answered, ascending: true), NSSortDescriptor(keyPath: \PrayerRequest.dateRequested, ascending: false)
            ]
        return request
    }
*/
//// object id to use in lookup
//    public var id: NSManagedObjectID {
//        return self.objectID
//    }
}

/*
@NSManaged public var answered: Bool
@NSManaged public var dateRequested: Date?
@NSManaged public var prayer: String?
@NSManaged public var topic: String?
@NSManaged public var tags: NSSet?
@NSManaged public var verses: NSSet?
*/

// relationships
// tags -> Tag, verses -> Verse
