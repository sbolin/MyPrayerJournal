//
//  OldPrayerJournalView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 27-Oct-21.
//

import SwiftUI
import CoreData

struct OldPrayerJournalView: View {
    var requestController: CoreDataController = .shared

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: PrayerRequest.fetchRequest())
    var requests: FetchedResults<PrayerRequest>

    @FocusState var focusField: Bool
    @State private var isAddPrayerShowing: Bool = false
    @State private var editMode: EditMode = .inactive
    @State private var focusPrayer: PrayerRequest?

    @State private var searchText = ""
    var query: Binding<String> {
        Binding {
            searchText
        } set: { newValue in
            searchText = newValue
            requests.nsPredicate = newValue.isEmpty ? nil : NSPredicate(format: "place CONTAINS %@", newValue)
        }
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack {
                    FocusPrayerView(prayerRequest: focusPrayer)
                        .padding()
                    List {
                        ActiveRequestsView()
                        PendingRequestsView()
                    } // List
                    .listStyle(.insetGrouped)
                    .navigationTitle("Prayer Journal")
                    //                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            HStack {
                                Spacer()
                                Button {
                                    focusField = false //focusField = nil
                                } label: {
                                    Image(systemName: "keyboard.chevron.compact.down")
                                } // Button/label
                            } // HStack
                        } // ToolbarItemGroup
                    } // toolbar
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            EditButton()
                                .buttonStyle(.bordered)
                            Button {
                                isAddPrayerShowing = true
                            } label: {
                                Label("Add Request", systemImage: "plus.circle.fill")
                            }
                            .disabled(editMode.isEditing)
                        }
                    }
                    .sheet(isPresented: $isAddPrayerShowing) {
                        AddPrayerView(viewModel: AddPrayerViewModel(isAddPrayerShowing: $isAddPrayerShowing))
                    } // Sheet
                } // VStack
                Button {
                    isAddPrayerShowing = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .clipShape(Circle())
                } //Button/label
            } // ZStack
        } // Navigation
        .navigationViewStyle(.stack) //
    } // view

        private func addItem() {
            withAnimation {
                let newRequest = PrayerRequest(context: viewContext)
                newRequest.request = ""

            }
        }

        private func deleteItems(offsets: IndexSet) {
            withAnimation {
                offsets.map { requests[$0] }.forEach(viewContext.delete)

                do {
                    try viewContext.save()
                } catch {
                    print("Could not delete item", error.localizedDescription)
                }
            }
        }
}

struct OldPrayerJournalView_Previews: PreviewProvider {
    static var previews: some View {
        OldPrayerJournalView()
            .environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
    }
}
