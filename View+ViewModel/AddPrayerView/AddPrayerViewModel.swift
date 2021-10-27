//
//  AddPrayerViewModel.swift
//  AddPrayerViewModel
//
//  Created by Scott Bolin on 8-Oct-21.
//

import SwiftUI

final class AddPrayerViewModel: ObservableObject {

    @Environment(\.managedObjectContext) var moc

    @Published var prayerRequest = ""
    @Published var prayerTopic = ""
    @Published var prayerLesson = ""
    @Published var prayerDate = Date()
    @Published var prayerTags: Set<PrayerTag> = [] // needs work...
    var isAddPrayerShowing: Binding<Bool>

    init(isAddPrayerShowing: Binding<Bool>) {
        self.isAddPrayerShowing = isAddPrayerShowing
    }

    func isValidForm() -> Bool {
        return prayerRequest.isEmpty
    }

    func savePrayer() {
        let newPrayer = PrayerRequest(context: moc)
        newPrayer.request = prayerRequest
        newPrayer.topic = prayerTopic
        newPrayer.lesson = prayerLesson
        newPrayer.dateRequested = prayerDate
        newPrayer.prayerTag = prayerTags

        CoreDataController.shared.save()
    }
}
