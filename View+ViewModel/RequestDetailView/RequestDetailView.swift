//
//  RequestDetailView.swift
//  RequestDetailView
//
//  Created by Scott Bolin on 7-Oct-21.
//

import SwiftUI

struct RequestDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var prayerRequest: PrayerRequest

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "checkmark.circle")
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundColor(.green)
            VStack(alignment: .leading) {
                HStack {
                    Text(prayerRequest.request ?? "Blank")
                    Spacer()
                    Text(prayerRequest.dateRequestedString)
                }
                HStack {
                    Text(prayerRequest.answeredString)
                    Spacer()
                    Text(prayerRequest.topicString)
                }
                HStack {
//                    prayerRequest.prayerTag.forEach { tag in
                    let tag = prayerRequest.prayerTag.first
                        let color = PrayerTag.colorDict[tag?.tagColor ?? 0]
                        SimpleTagView(text: tag?.tagName ?? "", fontSize: 12, tagTextColor: Color(.systemGray6), tagBGColor: color ?? .blue)
//                    }
                }
                HStack {
                    Text(prayerRequest.prayerVerse.first?.verseNameString ?? "No Verse")
                    Text(prayerRequest.prayerVerse.first?.verseTextString ?? "")
                }
            }
        }
//        .onAppear {
//            viewModel.selectedRequest = nil
//            viewModel.fetchAllTags()
//            viewModel.fetchAllVerses()
//        }
    }
}

struct RequestDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RequestDetailView(prayerRequest: getRequest())
    }
    static func getRequest() -> PrayerRequest {
        let context = CoreDataController.shared.container.viewContext
        let request = PrayerRequest(context: context)
        let prayerTag = PrayerTag(context: context)
        let prayerVerse = PrayerVerse(context: context)

        request.request = "A request"
        request.answered = false
        request.dateRequested = Date()
        request.focused = false
        request.lesson = "A lesson"
        request.statusID = 1
        request.topic = "A topic"
        prayerTag.tagName = "A Tag"
        prayerTag.tagColor = 1
        prayerVerse.book = "John"
        prayerVerse.chapter = "3"
        prayerVerse.startVerse = "16"
        prayerVerse.verseText = "For God so loved the world..."
        prayerTag.prayerRequest = request
        prayerVerse.prayerRequest = request
        return request
    }
}

