//
//  Tag+Ext.swift
//  MyPrayerJournal
//
//  Created by Scott Bolin on 17-Sep-21.
//

import CoreData

extension PrayerTag {

    enum NamedColor: Int {
        case black
        case blue
        case brown
        case clear
        case cyan
        case gray
        case green
        case indigo
        case mint
        case orange
        case pink
        case purple
        case red
        case teal
        case white
        case yellow
    }

    var namedColor: NamedColor {
        get {  return NamedColor(rawValue: Int(tagColor)) ?? .blue }
        set { tagColor = Int16(newValue.rawValue) }
    }

    var taggedRequest: PrayerRequest {
        get { prayerRequest! }
        set { prayerRequest = newValue }
    }

//    static var fetchAllTagsByRequest: NSFetchRequest<PrayerTag> {
//        let request: NSFetchRequest<PrayerTag> = PrayerTag.fetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(keyPath: \PrayerTag.prayerRequest, ascending: true)]
//        return request
//    }
}

/*
 @NSManaged public var tagColor: Int16
 @NSManaged public var tagName: String?
 @NSManaged public var request: PrayerRequest?
 */

// relationship
// request -> PrayerRequest