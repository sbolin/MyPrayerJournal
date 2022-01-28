//
//  RequestCardView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 11-Jan-22.
//

import SwiftUI

struct RequestCardView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var request: PrayerRequest
    let iconSize: Double = 22

    var backgroundColor: LinearGradient {
        switch request.statusID {
        case 0: return LinearGradient(gradient: Gradient(colors: [Color.white, Color.red.opacity(0.1)]), startPoint: .bottom, endPoint: .top)
        case 1: return LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]), startPoint: .bottom, endPoint: .top)
        case 2: return LinearGradient(gradient: Gradient(colors: [Color.white, Color.green.opacity(0.1)]), startPoint: .bottom, endPoint: .top)
        default: return LinearGradient(gradient: Gradient(colors: [Color.clear, Color.clear]), startPoint: .bottom, endPoint: .top)
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(request.requestString).font(.headline)
            Divider()
            HStack(spacing: 8) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("**Date**: \(request.dateRequestedString)")
                    if request.topic != nil {
                        Text("**Topic**: \(request.topicString)")
                    }
                    if request.verseText != nil {
                        Text("**Verse**: \(request.verseText ?? "")")
                    }
                    if request.lesson != nil {
                        Text("**Lesson**: \(request.lesson ?? "")")
                    }
                }
                .font(.footnote)
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
            } // HStack
            TagRowView(tags: request.prayerTag, fontSize: 11)
                .fixedSize()
        } // VStack
        .padding()
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .circular))
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

struct RequestCardView_Previews: PreviewProvider {
    static var previews: some View {
        RequestCardView(request: getRequest())
    }

    static func getRequest() -> PrayerRequest {
        let context = CoreDataController.shared.container.viewContext
        let request = PrayerRequest(context: context)
        let prayerTag = PrayerTag(context: context)
        let prayerVerse = PrayerVerse(context: context)

        request.request = "A semi-long request that needs an answer very quickly, if not right now, but which may need patience"
        request.answered = false
        request.dateRequested = Date()
        request.focused = false
        request.lesson = "A lesson"
        request.statusID = 2
        request.topic = "A topic"
        request.verseText = "For God so loved the world that he gave his only Son, that whoever believes in him should not perish but have eternal life."
        prayerTag.tagName = "A Tag"
        prayerTag.color = .systemIndigo
        prayerVerse.book = "John"
        prayerVerse.chapter = "3"
        prayerVerse.startVerse = "16"
        prayerVerse.verseText = "For God so loved the world that he gave his only Son, that whoever believes in him should not perish but have eternal life."
        prayerTag.prayerRequest = request
        prayerVerse.prayerRequest = request
        return request
    }
}
