//
//  PrayerJournalGridView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 12-Jan-22.
//

import SwiftUI

struct PrayerJournalGridView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let coreDataManager: CoreDataController = .shared

    @FetchRequest<PrayerRequest>(
        sortDescriptors: [
            SortDescriptor(\PrayerRequest.statusID, order: .forward),
            SortDescriptor(\PrayerRequest.dateRequested, order: .forward),
            SortDescriptor(\PrayerRequest.request, order: .forward)
        ],
        animation: .default)
    private var requests: FetchedResults<PrayerRequest>

    private var activeRequests: [PrayerRequest] {
        requests.filter { $0.answered == false && $0.focused == false }
    }

    private var answeredRequests: [PrayerRequest] {
        requests.filter { $0.answered == true }
    }

    private var focusRequests: [PrayerRequest] {
        requests.filter { $0.focused == true }
    }

    @State private var isAddPrayerShowing: Bool = false
    @State var selectedSort = RequestSort.default
    @State private var searchText = ""

    private var columns: [GridItem] = [GridItem(.adaptive(minimum: 200, maximum: 300))]

    var query: Binding<String> {
        Binding {
            searchText
        } set: { newValue in
            let compoundPredicate = NSPredicate(format: "%K CONTAINS[cd] %@ OR %K CONTAINS[cd] %@ OR %K CONTAINS[cd] %@", #keyPath(PrayerRequest.request), newValue,
                                                #keyPath(PrayerRequest.topic), newValue,
                                                #keyPath(PrayerRequest.prayerTags.tagName), newValue)
            searchText = newValue
            requests.nsPredicate = newValue.isEmpty ? nil : compoundPredicate
        }
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                ScrollView {
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 8, pinnedViews: [.sectionHeaders, .sectionFooters]) {
                        // Focus Requests
                        Section {
                            ForEach(focusRequests) { request in
                                NavigationLink {
                                    AddRequestView(requestId: request.objectID)
                                } label: {
                                    RequestListCell(request: request)
                                } // NavigationLink
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        deleteRequest(request: request)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                } // swipe
                                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                                    Button {
                                        completeRequest(request: request)
                                    } label: {
                                        Image(systemName: "checkmark.circle")
                                            .foregroundColor(.green)
                                    }
                                } // swipe
                            } // ForEach
                        } header: {
                            Label("Focus", systemImage: "target")
                                .foregroundColor(.pink)
                        } footer: {
                            HStack {
                                Spacer()
                                Text("\(focusRequests.count) Focus Requests")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            } // HStack
                        } // footer/header/Section
                          // Active Requests
                        Section {
                            ForEach(activeRequests) { request in
                                NavigationLink {
                                    AddRequestView(requestId: request.objectID)
                                } label: {
                                    RequestListCell(request: request)
                                } // NavigationLink
                                .swipeActions {
                                    Button(role: .destructive) {
                                        deleteRequest(request: request)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                    Button {
                                        completeRequest(request: request)
                                    } label: {
                                        Image(systemName: "checkmark.circle")
                                            .foregroundColor(.green)
                                    } // Button/labbel
                                } // swipeActions
                            } // ForEach
                        } header: {
                            Label("Requests", systemImage: "checkmark.circle")
                                .foregroundColor(.blue)
                        } footer: {
                            HStack {
                                Spacer()
                                Text("\(activeRequests.count) Requests Remain")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            } // HStack
                        } // Section/header/footer
                          // Answered requests
                        Section {
                            ForEach(answeredRequests) { request in
                                NavigationLink {
                                    AddRequestView(requestId: request.objectID)
                                } label: {
                                    RequestListCell(request: request)
                                } // NavigationLink
                                .swipeActions {
                                    Button(role: .destructive) {
                                        deleteRequest(request: request)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                    Button {
                                        completeRequest(request: request)
                                    } label: {
                                        Image(systemName: "checkmark.circle")
                                            .foregroundColor(.green)
                                    } // button/label
                                } // swipe actions
                            } // ForEach
                        } header: {
                            Label("Answered", systemImage: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        } footer: {
                            HStack {
                                Spacer()
                                Text("\(answeredRequests.count) Anwsered Requests")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            } // Hstack
                        } // Section/header/footer
                    } // LazyVGrid
                } // ScrollView
                .padding()
                .searchable(text: query)
                .listSectionSeparator(.automatic)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        SortSelectionView(selectedSortItem: $selectedSort, sorts: RequestSort.sorts)
                            .onChange(of: selectedSort) { _ in
                                let request = requests
                                request.sortDescriptors = selectedSort.descriptors
                            } // onChange
                    } // ToolbarItemGroup

                    ToolbarItemGroup(placement: .principal) {
                        HStack {
                            Image(systemName: "sun.max.fill")
                                .foregroundColor(.yellow)
                            Text("Prayer Request").font(.title2).bold()
                                .foregroundColor(.indigo)
                        }
                    } // ToolbarItemGroup
                } // toolbar

                NavigationLink(destination: AddRequestView()) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 44, height: 44, alignment: .center)
                        .foregroundColor(.green)
                        .padding(.bottom, 4)
                } // NavigationLink
            } // ZStack
            .navigationBarTitleDisplayMode(.inline)
        } // NavigationView
        .environment(\.defaultMinListRowHeight, 40)
    } // View

    private func deleteRequest(request: PrayerRequest) {
        withAnimation {
            coreDataManager.deleteRequest(request: request, context: viewContext)
        }
    } // deleteRequest

    private func completeRequest(request: PrayerRequest) {
        withAnimation {
            let status = !request.answered
            coreDataManager.updatePrayerCompletion(request: request, isCompleted: status, context: viewContext)
        }
    } // deleteRequest
} // ContentView

struct PrayerJournalGridView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerJournalGridView()
    }
}
