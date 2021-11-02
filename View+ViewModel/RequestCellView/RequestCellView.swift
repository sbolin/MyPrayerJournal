//
//  RequestCellView.swift
//  RequestCellView
//
//  Created by Scott Bolin on 5-Oct-21.
//

import SwiftUI

struct RequestCellView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var prayerRequest: PrayerRequest
    var coreDataController: CoreDataController = .shared
//
    var isCompleted: Binding<Bool> {
        Binding(
            get: {
                prayerRequest.answered
            },
            set: { isCompleted, transaction in
                withTransaction(transaction) {
                    coreDataController.updatePrayerCompletion(request: prayerRequest, isCompleted: isCompleted)
                }
            })
    }
    
    var body: some View {
        HStack {
            Toggle("", isOn: isCompleted) // prayerRequest.answered
                .toggleStyle(CheckboxToggleStyle())

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(prayerRequest.requestString).font(.title)
                    Spacer()
                    Text(prayerRequest.dateRequestedString)
                }
                    Text(prayerRequest.topicString)

                HStack {
                    let tag = prayerRequest.prayerTag.first
                    let color = PrayerTag.colorDict[tag?.tagColor ?? 0]
                    SimpleTagView(text: tag?.tagName ?? "", fontSize: 12, tagTextColor: Color(.systemGray6), tagBGColor: color ?? .blue)
                }

                HStack {
                    Text(prayerRequest.prayerVerse.first?.verseNameString ?? "No Verse")
                    Spacer()
                    Text(prayerRequest.prayerVerse.first?.verseTextString ?? "No Verse")
                }
            }
        }
        .padding()
        .background(PrayerTag.colorDict[Int16((Int.random(in: 0...18)))].opacity(0.10))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
//        .cornerRadius(30)
    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestCellView(prayerRequest: getRequest())
    }
    static func getRequest() -> PrayerRequest {
        let context = CoreDataController.shared.container.viewContext
        let request = PrayerRequest(context: context)
        let prayerTag = PrayerTag(context: context)
        let prayerVerse = PrayerVerse(context: context)

        request.request = "A request"
        request.answered = true
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

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: configuration.isOn ? "checkmark.circle" : "circle")
            .resizable()
            .frame(width: 32, height: 32)
            .foregroundColor(configuration.isOn ? .green : .black)
            .onTapGesture { configuration.isOn.toggle() }
    }
}
