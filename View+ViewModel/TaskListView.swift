//
//  TaskListView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 17-Nov-21.
//

import SwiftUI

struct TaskListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var request: PrayerRequest

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
//                    Text(request.prayerVerse.first?.verseNameString ?? "No Verse")
//                    Text(request.prayerVerse.first?.verseTextString ?? "No Verse")
                let tag = request.prayerTag.first
                let color = PrayerTag.colorDict[tag?.tagColor ?? 1]
                if let text = tag?.tagName {
                    SimpleTagView(text: text, fontSize: 12, tagTextColor: Color(.white), tagBGColor: color ?? .blue)
                } else {
                    EmptyView()
                }
            }
            .font(.caption)
            Spacer()

            Image(systemName: request.answered ? "checkmark.circle.fill": "checkmark.circle")
                .foregroundColor(.green)
                .onTapGesture {
                    withAnimation {
                        updateRequest()
                    }
                }
            Image(systemName: request.focused ? "target": "scope")
                .foregroundColor(.red)
                .onTapGesture {
                    withAnimation {
                        updateFocus()
                    }
                }
        }
        .padding()
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .circular))
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

//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        let context = CoreDataManager.preview.container.viewContext
//        TodoListView(task: Task(context: context))
//            .environment(\.managedObjectContext, context)
//    }
//}

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
