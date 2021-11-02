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
    var coreDataController: CoreDataController = .shared

    @SectionedFetchRequest<String, PrayerRequest>(
        sectionIdentifier: \PrayerRequest.statusString,
        sortDescriptors: [SortDescriptor(\PrayerRequest.statusID, order: .forward)],
        animation: .default)
    private var requests: SectionedFetchResults<String, PrayerRequest>

//    @FocusState var focusField: Bool
    @State private var editMode: EditMode = .inactive
    @State private var isAddPrayerShowing: Bool = false

    @State var selectedSort = RequestSort.default
//    @State var selection: [PrayerRequest] = []
    @State private var searchText = ""

    var query: Binding<String> {
        Binding {
            searchText
        } set: { newValue in
            searchText = newValue
            requests.nsPredicate = newValue.isEmpty ? nil : NSPredicate(format: "request CONTAINS %@", newValue)
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(requests, id: \.id) { section in
                    Section(header: Text(section.id)) {
                        ForEach(section, id: \.id) { request in
                            NavigationLink {
                                AddRequestView(requestId: request.objectID)
                            } label: {
                                RequestCellView(prayerRequest: request)
                            } // RequestDetailViewModel
                        } // ForEach
                        .onDelete { indexSet in
                            withAnimation {
                                coreDataController.deleteItem(for: indexSet, section: section, viewContext: viewContext)
                            } // withAnimation
                        } // onDelete
                    } // Section
                } // ForEach
            } // List
//          .environment(\.editMode, $editMode)
            .listStyle(.insetGrouped)
            .searchable(text: query)
            .navigationTitle("Prayer Journal")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    //                  EditButton()
                    //                    .buttonStyle(.bordered)
                    Button {
                        isAddPrayerShowing = true
                    } label: {
                        Label("Add Request", systemImage: "plus.circle.fill")
                    }
                    .disabled(editMode.isEditing)
                } // ToolbarItemGroup

                ToolbarItemGroup(placement: .navigationBarLeading) {
                    SortSelectionView(selectedSortItem: $selectedSort, sorts: RequestSort.sorts)
                        .onChange(of: selectedSort) { _ in
                            let request = requests
                            request.sectionIdentifier = selectedSort.section
                            request.sortDescriptors = selectedSort.descriptors
                        } // onChange
                } // ToolbarItemGroup

            } // toolbar
            .sheet(isPresented: $isAddPrayerShowing) {
                AddRequestView()
            } // Sheet
              //                Button {
              //                    isAddPrayerShowing = true
              //                } label: {
              //                    Image(systemName: "plus")
              //                        .font(.title.bold())
              //                        .foregroundColor(.white)
              //                        .padding()
              //                        .background(Color.green)
              //                        .clipShape(Circle())
              //                } //Button/label
              //            .listStyle(.insetGrouped)
            //          .navigationBarTitleDisplayMode(.inline)
        } // Navigation
          //        .navigationViewStyle(.stack) // force single column style
    } // view

    //    private func addItem() {
    //        withAnimation {
    //            let newRequest = PrayerRequest(context: viewContext)
    //            newRequest.request = ""
    //        }
    //    }

    //    private func deleteItems(offsets: IndexSet) {
    //        withAnimation {
    //            offsets.map { requests[$0] }.forEach(viewContext.delete)
    //
    //            do {
    //                try viewContext.save()
    //            } catch {
    //                print("Could not delete item", error.localizedDescription)
    //            }
    //        }
    //    }
}

struct SimpleView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerJournalView()
        //            .environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
    }
}
