//
//  PrayerJournalView.swift
//  MyPrayerJournal
//
//  Created by Scott Bolin on 4-Oct-21.
//

import SwiftUI
// import CoreData

// not used anymore, but keep 'just in case'

/*

struct PrayerJournalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var coreDataController: CoreDataController = .shared

    @SectionedFetchRequest(
        sectionIdentifier: \PrayerRequest.statusString,
        sortDescriptors: [SortDescriptor(\PrayerRequest.statusID, order: .forward)],
        animation: .default)
    private var requests: SectionedFetchResults<String, PrayerRequest>

//    @FocusState var focusField: Bool
    @State private var isAddPrayerShowing: Bool = false
    @State var selectedSort = RequestSort.default
    @State private var searchText = ""

    var query: Binding<String> {
        Binding {
            searchText
        } set: { newValue in
            let compoundPredicate = NSPredicate(format: "%K CONTAINS[cd] %@ OR %K CONTAINS[cd] %@ OR %K CONTAINS[cd] %@",
                                                #keyPath(PrayerRequest.request), newValue,
                                                #keyPath(PrayerRequest.topic), newValue,
                                                #keyPath(PrayerRequest.prayerTags.tagName), newValue)

            searchText = newValue
            requests.nsPredicate = newValue.isEmpty ? nil : compoundPredicate
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(requests) { section in
                    Section(header: Text(section.id)) {
                        ForEach(section) { request in
                            NavigationLink {
                                AddRequestView(requestId: request.objectID)
                            } label: {
                                RequestCellView(prayerRequest: request)
                            } // NavigationLink
                        } // ForEach
                        .onDelete { indexSet in
                            withAnimation {
                                coreDataController.deleteItem(for: indexSet, section: section, viewContext: viewContext)
                            } // withAnimation
                        } // onDelete
                    } // Section
                } // ForEach
            } // List
            .listStyle(.plain)
//          .environment(\.editMode, $editMode)
            .searchable(text: query)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        isAddPrayerShowing = true
                    } label: {
                        Label("Add Request", systemImage: "plus.circle.fill")
                    }
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
            .navigationTitle("Prayer Journal")
        } // Navigation
    } // view
}

struct PrayerJournalView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerJournalView()
    }
}
*/
