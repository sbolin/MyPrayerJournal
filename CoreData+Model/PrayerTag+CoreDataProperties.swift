//
//  PrayerTag+CoreDataProperties.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 1-Dec-21.
//
//

import Foundation
import CoreData
import SwiftUI


extension PrayerTag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PrayerTag> {
        return NSFetchRequest<PrayerTag>(entityName: "PrayerTag")
    }

    @NSManaged public var color: UIColor?
    @NSManaged public var id: UUID?
    @NSManaged public var tagName: String?
    @NSManaged public var prayerRequest: PrayerRequest?

    public var tagNameString: String {
        tagName ?? ""
    }

    public var tagColor: Color {
        Color(color ?? UIColor.blue)
    }

}

extension PrayerTag : Identifiable {

}
