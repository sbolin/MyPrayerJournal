//
//  TagValues.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 30-Oct-21.
//

import Foundation


struct TagValues: Hashable {
    let tagColor: Int16
    let tagName: String?
    let prayerRequest: PrayerRequestValues?
    func hash(into hasher: inout Hasher) {
        hasher.combine(tagName)
        hasher.combine(tagColor)
    }

    static func == (lhs: TagValues, rhs: TagValues) -> Bool {
        lhs.tagName == rhs.tagName
    }
}
