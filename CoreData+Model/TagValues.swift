//
//  TagValues.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 30-Oct-21.
//

import SwiftUI

struct TagValues: Hashable, Identifiable {
    var id = UUID()
    var tagColor: Int16
    var tagName: String
    var tagSize: CGFloat = 0
//    let prayerRequest: PrayerRequestValues
}
