//
//  RequestCellViewModel.swift
//  RequestCellViewModel
//
//  Created by Scott Bolin on 11-Oct-21.
//

import SwiftUI

final class RequestCellViewModel: ObservableObject {

    @Published var allTagsForRequest: [PrayerTag] = []
    @Published var allVersesForRequest: [PrayerVerse] = []
    @Published var isComplete: Bool = false

    var prayerRequest: PrayerRequest

    init(prayerRequest: PrayerRequest) {
        self.prayerRequest = prayerRequest
        self.isComplete = prayerRequest.answered
        fetchAllTags()
        fetchAllVerses()
    }

    func fetchAllTags() {
        allTagsForRequest = CoreDataController.shared.fetchTags(for: prayerRequest) ?? []
    }

    func fetchAllVerses() {
        allVersesForRequest = CoreDataController.shared.fetchVerses(for: prayerRequest) ?? []
    }
}
