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
            name: "Status | Ascending",
            descriptors: [
                SortDescriptor(\PrayerRequest.statusID, order: .forward)],
            section: \PrayerRequest.statusString),
        RequestSort(
            id: 1,
            name: "Status | Descending",
            descriptors: [
                SortDescriptor(\PrayerRequest.statusID, order: .reverse)],
            section: \PrayerRequest.statusString),
        RequestSort(
            id: 2,
            name: "Date | Ascending",
            descriptors: [
                SortDescriptor(\PrayerRequest.dateRequested, order: .forward)],
            section: \PrayerRequest.dateRequestedString),
        RequestSort(
            id: 3,
            name: "Date | Descending",
            descriptors: [
                SortDescriptor(\PrayerRequest.dateRequested, order: .reverse)],
            section: \PrayerRequest.dateRequestedString),
        RequestSort(
            id: 4,
            name: "Topic | Ascending",
            descriptors: [
                SortDescriptor(\PrayerRequest.topicString, order: .forward)],
            section: \PrayerRequest.topicString),
        RequestSort(
            id: 5,
            name: "Topic | Decending",
            descriptors: [
                SortDescriptor(\PrayerRequest.topicString, order: .reverse)],
            section: \PrayerRequest.topicString)
    ]

    static var `default`: RequestSort { sorts[0] }
}

/*
 @SectionedFetchRequest<String, PrayerRequest>(
sectionIdentifier: \PrayerRequest.statusString,
sortDescriptors: [SortDescriptor(\PrayerRequest.statusID, order: .forward)],
animation: .default)
*/
