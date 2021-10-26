//
//  RequestDetailViewModel.swift
//  RequestDetailViewModel
//
//  Created by Scott Bolin on 8-Oct-21.
//

import SwiftUI

final class RequestDetailViewModel: ObservableObject {

//    @Environment(\.managedObjectContext) var moc

    @Published var allTagsForRequest: [PrayerTag] = []
    @Published var allVersesForRequest: [PrayerVerse] = []
    @Published var isNavigationLinkActive: Bool = false
    @Published var selectedRequest: PrayerRequest?

    var prayerRequest: PrayerRequest

    init(prayerRequest: PrayerRequest) {
        self.prayerRequest = prayerRequest
    }

    func fetchAllTags() {
        allTagsForRequest = CoreDataController.shared.fetchTags(for: prayerRequest) ?? []
    }

    func fetchAllVerses() {
        allVersesForRequest = CoreDataController.shared.fetchVerses(for: prayerRequest) ?? []
    }
}
