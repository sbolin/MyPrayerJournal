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

    @State private var request: String = "" //
    @State private var answered: Bool = false
    @State private var dateRequested: Date = Date() //
    @State private var focused: Bool = false //
    @State private var lesson: String = "" //
    @State private var statusID: Int16 = 1
    @State private var topic: String = "" //
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
                            .frame(minHeight: 100)
                    }
                    if requestError {
                        Text("Request is required").foregroundColor(.red)
                    }
                    TextField("Prayer Topic", text: $topic, prompt: Text("Prayer Topic"))
                    TextField("Prayer Lesson", text: $lesson, prompt: Text("Prayer Lesson"))
                    TextField("Verse, if any", text: $verseText, prompt: Text("Prayer Verse, if any"))
                    DatePicker("Requested on", selection: $dateRequested, displayedComponents: .date)
                }

                Section("Status") {
                    Toggle("Focus", isOn: $focused)
                    Toggle("Answered", isOn: $answered)
                }
                .tint(.mint)

                Section("Tags") {
                    TextField("Prayer Tags, if any", text: $requestTag, prompt: Text("Prayer Tags, if any"))
                }
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
                //                        .disabled(request.isEmpty)

                Spacer()

                Button {
                    if request.isEmpty {
                        requestError = request.isEmpty
                    } else {
                        statusID = 1
                        if focused { statusID = 0 }
                        if answered { statusID = 2 }
                        let values = PrayerRequestValues(
                            request: request,
                            answered: answered,
                            dateRequested: dateRequested,
                            focused: focused,
                            lesson: lesson,
                            statusID: statusID,
                            topic: topic,
                            verseText: verseText,
                            requestTag: requestTag,
                            prayerTags: prayerTags,
                            prayerVerses: prayerVerses)
                        viewModel.savePrayer(requestID: requestId, with: values, in: viewContext)
                        presentation.wrappedValue.dismiss()
                    }
                } label: {
                    Text("Save")
                        .fontWeight(.medium)
                }
                .buttonStyle(.borderedProminent)
                .accentColor(.green)
                .disabled(request.isEmpty)
            } // HStack
            .padding(.horizontal)
        } // VStack
        .navigationTitle("\(requestId == nil ? "Add Request" : "Edit Request")")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            guard let requestId = requestId, let prayer = viewModel.fetchPrayer(for: requestId, context: viewContext) else { return }
            request = prayer.request ?? ""
            answered = prayer.answered
            dateRequested = prayer.dateRequested ?? Date()
            focused = prayer.focused
            lesson = prayer.lesson ?? ""
            statusID = prayer.statusID
            topic = prayer.topic ?? ""
            requestTag = prayer.requestTag ?? ""
            verseText = prayer.verseText ?? ""
            prayerTags = prayer.prayerTag
            prayerVerses = prayer.prayerVerse
        }
    }
}

struct RequestForm_Previews: PreviewProvider {
    static var previews: some View {
        AddRequestView()
        //            .environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
    }
}


