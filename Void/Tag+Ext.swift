//
//  Tag+Ext.swift
//  MyPrayerJournal
//
//  Created by Scott Bolin on 17-Sep-21.
//

import CoreData
import SwiftUI
/*
extension PrayerTag {

    var colorValue: UIColor {
        return color as? UIColor ?? .white
    }

    static func tagNamed(_ name: String, in context: NSManagedObjectContext) -> PrayerTag? {
        let fetch = PrayerTag.fetchRequest()
        fetch.predicate = NSPredicate(format: "name LIKE[cd] %@", name)
        let results = (try? context.fetch(fetch)) ?? []
        return results.first
    }



    static var colorDict: [Int16:Color] {
        [0 : .black,
         1 : .blue,
         2 : .brown,
         3 : .clear,
         4 : .cyan,
         5 : .gray,
         6 : .green,
         7 : .indigo,
         8 : .mint,
         9 : .orange,
         10 : .pink,
         11 : .purple,
         12 : .red,
         13 : .teal,
         14 : .white,
         15 : .yellow]
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
*/
