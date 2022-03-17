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
            name: "Default",
            descriptors: [
                SortDescriptor(\PrayerRequest.statusID, order: .reverse),
                SortDescriptor(\PrayerRequest.dateRequested, order: .reverse),
                SortDescriptor(\PrayerRequest.request, order: .forward)],
            section: \PrayerRequest.statusString),

//        RequestSort(
//            id: 1,
//            name: "By Status",
//            descriptors: [
//                SortDescriptor(\PrayerRequest.statusID, order: .forward),
//                SortDescriptor(\PrayerRequest.dateRequested, order: .forward),
//            SortDescriptor(\PrayerRequest.request, order: .forward)],
//            section: \PrayerRequest.statusString),

        RequestSort(
            id: 1,
            name: "By Date | Increasing",
            descriptors: [
                SortDescriptor(\PrayerRequest.dateRequested, order: .forward),
                SortDescriptor(\PrayerRequest.request, order: .forward)],
            section: \PrayerRequest.groupByDay),

        RequestSort(
            id: 2,
            name: "By Date | Decreasing",
            descriptors: [
                SortDescriptor(\PrayerRequest.dateRequested, order: .reverse),
                SortDescriptor(\PrayerRequest.request, order: .forward)],
            section: \PrayerRequest.groupByDay),

        RequestSort(
            id: 3,
            name: "By Request | Increasing",
            descriptors: [
                SortDescriptor(\PrayerRequest.request, order: .forward),
                SortDescriptor(\PrayerRequest.dateRequested, order: .forward)],
            section: \PrayerRequest.groupByDay),

        RequestSort(
            id: 4,
            name: "By Request | Decreasing",
            descriptors: [
                SortDescriptor(\PrayerRequest.request, order: .reverse),
                SortDescriptor(\PrayerRequest.dateRequested, order: .reverse)],
            section: \PrayerRequest.groupByDay),

//        RequestSort(
//            id: 3,
//            name: "By Week",
//            descriptors: [
//                SortDescriptor(\PrayerRequest.dateRequested, order: .forward),
//                SortDescriptor(\PrayerRequest.request, order: .forward)],
//            section: \PrayerRequest.groupByWeek),
//
//        RequestSort(
//            id: 4,
//            name: "By Month",
//            descriptors: [
//                SortDescriptor(\PrayerRequest.dateRequested, order: .forward),
//                SortDescriptor(\PrayerRequest.request, order: .forward)],
//            section: \PrayerRequest.groupByMonth),
//
//        RequestSort(
//            id: 5,
//            name: "By Request | Month",
//            descriptors: [
//                SortDescriptor(\PrayerRequest.request, order: .forward)],
//            section: \PrayerRequest.groupByMonth)
    ]
    static var `default`: RequestSort { sorts[0] }
}

/*
 @SectionedFetchRequest<String, PrayerRequest>(
sectionIdentifier: \PrayerRequest.statusString,
sortDescriptors: [SortDescriptor(\PrayerRequest.statusID, order: .forward)],
animation: .default)
*/
