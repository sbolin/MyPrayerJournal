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

//    @ObservedObject var viewModel: AddPrayerViewModel
//    let placeholderString: String? = "Prayer?"
//    @State var prayerRequest: PrayerRequest
    @State var tags: String? = ""

    var friendId: NSManagedObjectID?
    let viewModel = AddRequestViewModel()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        presentation.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    .buttonStyle(.bordered)

                    Spacer()

                    Button {
                        viewModel.savePrayer()
                        presentation.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                            .fontWeight(.medium)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.isValidForm())
                }
                .padding()

                Form {
                    Section(header: Text("Prayer Request")) {
                        ZStack(alignment: .topLeading) {
                            if viewModel.prayerRequest.isEmpty {
                                Text("Prayer?")
                                    .foregroundColor(Color(UIColor.placeholderText))
                                    .font(.body)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 8)
                            }
                            TextEditor(text: $viewModel.prayerRequest)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                                .allowsTightening(false)
                                .textInputAutocapitalization(.sentences)
                        }

                        TextField("Prayer Topic, if any", text: $viewModel.prayerTopic)
                        TextField("Prayer Lesson, if any", text: $viewModel.prayerLesson)
    //                    TextField("Prayer Tags, if any", text: $tags)
                        DatePicker("Start Date", selection: $viewModel.prayerDate, displayedComponents: .date)
                    }
                    .font(.body)
                    .textFieldStyle(.automatic)
                }
            }
        }
    }
}

struct RequestForm_Previews: PreviewProvider {
    static var previews: some View {
        AddPrayerView(viewModel: AddPrayerViewModel(isAddPrayerShowing: .constant(false)), tags: "Tag")
            .environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
    }
}

