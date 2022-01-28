//
//  AddRequestView.swift
//  RequestForm
//
//  Created by Scott Bolin on 13-Sep-21.
//

import CoreData
import SwiftUI

struct AddRequestView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @ObservedObject var notificationManager: NotificationManager

    @State private var request: String = ""
    @State private var answered: Bool = false
    @State private var dateRequested: Date = Date()
    @State private var focused: Bool = false
    @State private var id: UUID = UUID()
    @State private var lesson: String = ""
    @State private var notifiable: Bool = true
    @State private var notifyTime: Date = Date()
    @State private var statusID: Int16 = 1
    @State private var topic: String = ""
    @State private var requestTag: String = ""
    @State private var verseText: String = ""
    @State private var prayerTags: Set<PrayerTag> = Set<PrayerTag>()
    @State private var prayerVerses: Set<PrayerVerse> = Set<PrayerVerse>()

    @State private var requestError = false

    var requestId: NSManagedObjectID?
    let viewModel = AddRequestViewModel()

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Prayer Request")) {
                    // use ZStack to mimic TextField title (TextEditor does not have this)
                    ZStack(alignment: .topLeading) {
                        if request.isEmpty {
                            Text("Request?")
                                .foregroundColor(Color(UIColor.placeholderText))
                                .font(.body)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 8)
                        }
                        TextEditor(text: $request)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .allowsTightening(false)
                            .textInputAutocapitalization(.sentences)
                            .frame(minHeight: 72)
                    }
                    if requestError {
                        Text("Request is required").foregroundColor(.red)
                    }
                    TextField("Topic", text: $topic, prompt: Text("Prayer Topic"))
                    TextField("Lesson", text: $lesson, prompt: Text("Lesson"))
                    TextField("Verse, if any", text: $verseText, prompt: Text("Verse, if any"))
                    DatePicker("Requested on", selection: $dateRequested, displayedComponents: .date)
                }
                Section("Status") {
                    HStack {
                        Text("Focus")
                        Spacer()
                        Toggle(isOn: $focused) {
                            Image(systemName: focused ? "target": "scope")
                                .font(.title2)
                                .foregroundColor(.red)
                        }
                        .toggleStyle(.button)
                        .tint(.clear)
                    } // HStack

                    HStack {
                        Text("Answered")
                        Spacer()
                        Toggle(isOn: $answered) {
                            Image(systemName: "checkmark.circle")
                                .font(.title2)
                                .foregroundColor(.green)
                                .symbolVariant(answered ? .fill : .none)
                        }
                        .toggleStyle(.button)
                        .tint(.clear)
                    } // HStack
                    if focused { // focused
                        HStack {
                            Text("Notification")
                            Spacer()
                            Toggle(isOn: $notifiable) {
                                Image(systemName: "bell")
                                    .font(.title2)
                                    .foregroundColor(.pink)
                                    .symbolVariant(notifiable ? .fill : .none)
                            }
                            .toggleStyle(.button)
                            .tint(.clear)
                        }
                        if notifiable {
                            HStack {
                                Text("Notification Time")
                                Spacer()
                                DatePicker("", selection: $notifyTime, displayedComponents: [.hourAndMinute])
                                    .datePickerStyle(.compact)
                            } // HStack
                        }
                    }
                } // Section
                Section("Tags") {
                    AddTagView(prayerTags: $prayerTags)
                } // Section
            } // Form
            Spacer()
            HStack {
                Button {
                    presentation.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                }
                .buttonStyle(.bordered)
                .accentColor(.red)

                Spacer()

                Button {
                    if request.isEmpty {
                        requestError = request.isEmpty
                    } else {
                        addRequest()
                    }
                } label: {
                    Text("Save")
                        .fontWeight(.medium)
                }
                .buttonStyle(.borderedProminent)
                .accentColor(.green)
                .disabled(request.isEmpty)
            } // HStack
            .padding(.horizontal, 30)
        } // VStack
        .navigationTitle("\(requestId == nil ? "Add Request" : "Edit Request")")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            guard let requestId = requestId else { return }
            guard let prayer = viewModel.fetchPrayer(for: requestId, context: viewContext) else { return }
            request = prayer.requestString
            answered = prayer.answered
            dateRequested = prayer.dateRequested ?? Date()
            focused = prayer.focused
            id = prayer.id ?? UUID()
            lesson = prayer.lesson ?? ""
            notifiable = prayer.notifiable
            notifyTime = prayer.notifyTime ?? Date()
            statusID = prayer.statusID
            topic = prayer.topic ?? ""
            verseText = prayer.verseText ?? ""
            prayerTags = prayer.prayerTag
            prayerVerses = prayer.prayerVerse
        }
    } // body

    func addRequest() {
        statusID = 1
        if focused { statusID = 0 }
        if answered { statusID = 2 }
        let values = PrayerRequestValues(
            request: request,
            answered: answered,
            dateRequested: dateRequested,
            focused: focused,
            id: id,
            lesson: lesson,
            notifiable: notifiable,
            notifyTime: notifyTime,
            statusID: statusID,
            topic: topic,
            verseText: verseText,
            prayerTags: prayerTags,
            prayerVerses: prayerVerses)
        viewModel.savePrayer(requestID: requestId, with: values, in: viewContext)

        // generate notification if focused request
        if focused {
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: notifyTime)
            guard let hour = dateComponents.hour, let minute = dateComponents.minute else { return }
            notificationManager.createLocalNotification(title: "Daily Request Reminder",
                                                        subtitle: topic,
                                                        body: request,
                                                        notificationID: id.uuidString,
                                                        hour: hour,
                                                        minute: minute) { error in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                }
            }
        }
        presentation.wrappedValue.dismiss()
    }
}

struct RequestForm_Previews: PreviewProvider {
    static var previews: some View {
        AddRequestView(notificationManager: NotificationManager())
    }
}


