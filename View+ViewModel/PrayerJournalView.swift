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

// TODO: Preference to store last view state?

    @SectionedFetchRequest<String, PrayerRequest>(
        sectionIdentifier: \PrayerRequest.statusString,
        sortDescriptors: [SortDescriptor(\PrayerRequest.statusID, order: .forward)],
        animation: .default)
    var requests: SectionedFetchResults<String, PrayerRequest>

    @FocusState var focusField: Bool
    @State private var editMode: EditMode = .inactive
    @State private var isAddPrayerShowing: Bool = false

    @State var selection: [PrayerRequest] = []
    @State var selectedSort = RequestSort.default

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
            ZStack(alignment: .bottom) {
                List {
                    ForEach(requests) { section in
                        Section(header: Text(section.id)) {
                            ForEach(section, id: \.self) { request in
                                NavigationLink(destination: RequestDetailView(prayerRequest: request)) {
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

//                .environment(\.editMode, $editMode)
                .searchable(text: query)
                .toolbar {
//                    ToolbarItemGroup(placement: .keyboard) {
//                        HStack {
//                            Spacer()
//                            Button {
//                                focusField = false //focusField = nil
//                            } label: {
//                                Image(systemName: "keyboard.chevron.compact.down")
//                            } // Button/label
//                        } // HStack
//                    } // ToolbarItemGroup
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        SortSelectionView(selectedSortItem: $selectedSort, sorts: RequestSort.sorts)
                            .onChange(of: selectedSort) { _ in
                                let request = requests
                                request.sectionIdentifier = selectedSort.section
                                request.sortDescriptors = selectedSort.descriptors
                            }
                    }
//                    ToolbarItemGroup(placement: .navigationBarTrailing) {
//                        EditButton()
//                            .buttonStyle(.bordered)
//                        Button {
//                            isAddPrayerShowing = true
//                        } label: {
//                            Label("Add Request", systemImage: "plus.circle.fill")
//                        }
//                        .disabled(editMode.isEditing)
//                    } // ToolbarItemGroup
                } // toolbar
                .sheet(isPresented: $isAddPrayerShowing) {
                    AddRequestView(viewModel: AddPrayerViewModel(isAddPrayerShowing: $isAddPrayerShowing))
                } // Sheet
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
            .listStyle(.insetGrouped)
            .navigationTitle("Prayer Journal")
//          .navigationBarTitleDisplayMode(.inline)
        } // Navigation
        .navigationViewStyle(.stack) // force single column style
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
            .environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
    }
}
