//
//  RequestCellView.swift
//  RequestCellView
//
//  Created by Scott Bolin on 5-Oct-21.
//

import SwiftUI

// not used

/*

struct RequestCellView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var prayerRequest: PrayerRequest // @StateObject

    var backgroundColor: Color {
        switch prayerRequest.statusID {
        case 0: return .red.opacity(0.1)
        case 1: return .blue.opacity(0.1)
        case 2: return .green.opacity(0.1)
        default: return .clear
        }
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: prayerRequest.answered ? "checkmark.circle.fill": "checkmark.circle")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(.green)
                .onTapGesture {
                    withAnimation {
                        updateRequest()
                    }
                }
            VStack(alignment: .leading, spacing: 6) {
                Text(prayerRequest.requestString).font(.headline)
                Text("Date: \(prayerRequest.dateRequestedString)")
                Text("Topic: \(prayerRequest.topicString)")
                Text("Verse: \(prayerRequest.verseText ?? "")")
                //                    Text(prayerRequest.prayerVerse.first?.verseNameString ?? "No Verse")
                //                    Text(prayerRequest.prayerVerse.first?.verseTextString ?? "No Verse")

                let tag = prayerRequest.prayerTag.first
                let color = PrayerTag.colorDict[tag?.tagColor ?? 1]
                if let text = tag?.tagName {
                    SimpleTagView(text: text, fontSize: 12, tagTextColor: Color(.white), tagBGColor: color ?? .blue)
                } else {
                    EmptyView()
                }
            }
            .font(.caption)
//            .padding(.trailing)
            Spacer()
        }
        .padding()
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .circular))
    }

    private func updateRequest() {
        withAnimation {
            let oldValue = prayerRequest.answered
            prayerRequest.answered = !oldValue
            if !oldValue {
                prayerRequest.focused = false
                prayerRequest.statusID = 2
            } else {
                prayerRequest.statusID = 1
            }
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
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
        request.verseText = "For God so loved the world that he gave his only Son, that whoever believes in him should not perish but have eternal life."
        prayerTag.tagName = "A Tag"
//        prayerTag.tagColor = 1
        prayerVerse.book = "John"
        prayerVerse.chapter = "3"
        prayerVerse.startVerse = "16"
        prayerVerse.verseText = "For God so loved the world that he gave his only Son, that whoever believes in him should not perish but have eternal life."
        prayerTag.prayerRequest = request
        prayerVerse.prayerRequest = request
        return request
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
            .resizable()
            .frame(width: 32, height: 32)
            .foregroundColor(configuration.isOn ? .green : .gray)
//            .onTapGesture { configuration.isOn.toggle() }
    }
}
*/
