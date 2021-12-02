//
//  RequestListCell.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 17-Nov-21.
//

import SwiftUI

struct RequestListCell: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var request: PrayerRequest
    let iconSize: Double = 28

    var backgroundColor: Color {
        switch request.statusID {
        case 0: return .red.opacity(0.1)
        case 1: return .blue.opacity(0.1)
        case 2: return .green.opacity(0.1)
        default: return .clear
        }
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
//            TextField("", text: $request.request ?? "")
                Text(request.requestString).font(.headline)
                Text("Date: \(request.dateRequestedString)")
                Text("Topic: \(request.topicString)")
                Text("Verse: \(request.verseText ?? "")")
//              Text(request.prayerVerse.first?.verseNameString ?? "No Verse")
//              Text(request.prayerVerse.first?.verseTextString ?? "No Verse")
                if let tag = request.prayerTag.first {
                    TagView(tag: tag, fontSize: 16)
                } else {
                    EmptyView()
                }
            }
            .font(.caption)
            Spacer()

            Image(systemName: request.answered ? "checkmark.circle.fill": "checkmark.circle")
                .resizable()
                .frame(width: iconSize, height: iconSize)
                .foregroundColor(.green)
                .onTapGesture {
                    withAnimation {
                        updateRequest()
                    }
                }
            Image(systemName: request.focused ? "target": "scope")
                .resizable()
                .frame(width: iconSize, height: iconSize)
                .foregroundColor(.red)
                .onTapGesture {
                    withAnimation {
                        updateFocus()
                    }
                }
        }
        .padding()
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
    }

    /// Helper function to unwrap optional binding
    // update request completion
    private func updateRequest() {
        withAnimation {
            let oldValue = request.answered
            request.answered = !oldValue
            // if request is answered, unfocus request
            if !oldValue {
                request.focused = false
                request.statusID = 2
            } else {
                request.statusID = 1
            }
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    // update focus
    private func updateFocus() {
        withAnimation {
            let oldValue = request.focused
            request.focused = !oldValue
            if !oldValue {
                request.statusID = 0
                request.answered = false
            } else {
                request.statusID = 1
            }
            // don't allow previously answered requests be focused
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }

        }
    }
}

struct RequestListCell_Previews: PreviewProvider {
    static var previews: some View {
        RequestListCell(request: getRequest())
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
  //      prayerTag.tagColor = 1
        prayerVerse.book = "John"
        prayerVerse.chapter = "3"
        prayerVerse.startVerse = "16"
        prayerVerse.verseText = "For God so loved the world that he gave his only Son, that whoever believes in him should not perish but have eternal life."
        prayerTag.prayerRequest = request
        prayerVerse.prayerRequest = request
        return request
    }
}

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
