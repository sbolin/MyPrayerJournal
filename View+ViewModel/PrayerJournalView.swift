//
//  PrayerJournalView.swift
//  MyPrayerJournal
//
//  Created by Scott Bolin on 4-Oct-21.
//

import SwiftUI
import CoreData

struct PrayerJournalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: PrayerRequest.fetchAllRequestsByDate)
    private var prayers: FetchedResults<PrayerRequest>
    @FocusState var focusField: Bool?
    @State private var isAddPrayerShowing: Bool = false
    @State private var editMode: EditMode = .inactive
    @State private var focusPrayer: PrayerRequest?

    //    @SectionedFetchRequest(fetchRequest: PrayerRequest.requestByStatus, sectionIdentifier: \PrayerRequest.answeredString)
    //    var requests: SectionedFetchRequest<String, PrayerRequest>

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack {
                    FocusPrayerView(prayerRequest: focusPrayer)
                        .padding()
                    List {
                        ActiveRequestsView()
                        PendingRequestsView()
    //                    ForEach(prayers) { prayer in
    //                        NavigationLink(destination: RequestDetailView(viewModel: RequestDetailViewModel(prayerRequest: prayer))) {
    //                            RequestCellView(prayerRequest: prayer)
    //                        }
    //                    }
    //                    .onDelete(perform: deleteItems)
                    }
                    .listStyle(.insetGrouped)
                    .navigationTitle("Prayer Journal")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            HStack {
                                Spacer()
                                Button {
                                    focusField = nil
                                } label: {
                                    Image(systemName: "keyboard.chevron.compact.down")
                                }
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            EditButton()
                                .buttonStyle(.bordered)
    //                        Button {
    //                            isAddPrayerShowing = true
    //                        } label: {
    //                            Label("Add Request", systemImage: "plus.circle.fill")
    //                        }
    //                        .disabled(editMode.isEditing)
                        }
                    }
                    .sheet(isPresented: $isAddPrayerShowing) {
                        AddPrayerView(viewModel: AddPrayerViewModel(isAddPrayerShowing: $isAddPrayerShowing))
                    } // Sheet
                }
                Button {
                    isAddPrayerShowing = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .clipShape(Circle())
                }
            } // VStack
        } // Navigation
        .navigationViewStyle(.stack) //
    }

    //    private func addItem() {
    //        withAnimation {
    //            let newRequest = PrayerRequest(context: viewContext)
    //            newRequest.prayer = ""
    //
    //        }
    //    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { prayers[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                print("Could not delete item", error.localizedDescription)
            }
        }
    }
}

struct SimpleView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerJournalView().environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
    }
}
