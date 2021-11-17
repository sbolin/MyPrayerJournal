//
//  RequestSort.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 27-Oct-21.
//

import Foundation

struct RequestSort: Hashable, Identifiable {
    let id: Int
    let name: String
    let descriptors: [SortDescriptor<PrayerRequest>]
    let section: KeyPath<PrayerRequest, String>

    static let sorts: [RequestSort] = [
        RequestSort(
            id: 0,
            name: "By Status",
            descriptors: [
                SortDescriptor(\PrayerRequest.statusID, order: .forward),
                SortDescriptor(\PrayerRequest.dateRequested, order: .forward)],
            section: \PrayerRequest.statusString),
//        RequestSort(
//            id: 1,
//            name: "Status | Descending",
//            descriptors: [
//                SortDescriptor(\PrayerRequest.statusID, order: .forward),
//                SortDescriptor(\PrayerRequest.dateRequested, order: .reverse)],
//            section: \PrayerRequest.statusString),
        RequestSort(
            id: 1, // 2
            name: "By Date",
            descriptors: [
                SortDescriptor(\PrayerRequest.dateRequested, order: .forward)],
            section: \PrayerRequest.dateRequestedString), // dateRequestedString
//        RequestSort(
//            id: 3,
//            name: "Date | Descending",
//            descriptors: [
//                SortDescriptor(\PrayerRequest.dateRequested, order: .reverse)],
//            section: \PrayerRequest.dateRequestedString), // dateRequestedString
        RequestSort(
            id: 2, // 4
            name: "By Request",
            descriptors: [
                SortDescriptor(\PrayerRequest.request, order: .forward)],
            section: \PrayerRequest.requestString),
//        RequestSort(
//            id: 5,
//            name: "Request | Decending",
//            descriptors: [
//                SortDescriptor(\PrayerRequest.request, order: .reverse)],
//            section: \PrayerRequest.requestString)
    ]
    static var `default`: RequestSort { sorts[0] }
}

/*
 @SectionedFetchRequest<String, PrayerRequest>(
sectionIdentifier: \PrayerRequest.statusString,
sortDescriptors: [SortDescriptor(\PrayerRequest.statusID, order: .forward)],
animation: .default)
*/
