//
//  ContentView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 17-Nov-21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let coreDataManager: CoreDataController = .shared

    @FetchRequest<PrayerRequest>(
        sortDescriptors: [SortDescriptor(\PrayerRequest.statusID, order: .forward), SortDescriptor(\PrayerRequest.dateRequested, order: .forward)],
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
            VStack {
                List {
                    // Focus requests
                    Section {
                        ForEach(focusRequests) { request in
                            NavigationLink {
                                AddRequestView(requestId: request.objectID)
                            } label: {
                                TaskListView(request: request)
                            } // NavigationLink
                        } // ForEach
                        .onDelete(perform: deleteRequest)
                    } header: {
                        Label("Focus", systemImage: "target")
                            .foregroundColor(.pink)
                    } footer: {
                        HStack {
                            Spacer()
                            Text("\(focusRequests.count) Focus Requests")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                    .accentColor(.pink)
                    // Active requests
                    Section {
                        ForEach(activeRequests) { request in
                            NavigationLink {
                                AddRequestView(requestId: request.objectID)
                            } label: {
                                TaskListView(request: request)
                            } // NavigationLink
                        } // ForEach
                        .onDelete(perform: deleteRequest)
                    } header: {
                        Label("Requests", systemImage: "checkmark.circle")
                            .foregroundColor(.blue)
                    } footer: {
                        HStack {
                            Spacer()
                            Text("\(activeRequests.count) requests remain")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                    .accentColor(.blue)
                    // Answered requests
                    Section {
                        ForEach(answeredRequests) { request in
                            NavigationLink {
                                AddRequestView(requestId: request.objectID)
                            } label: {
                                TaskListView(request: request)
                            } // NavigationLink
                        } // ForEach
                        .onDelete(perform: deleteRequest)
                    } header: {
                        Label("Answered", systemImage: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    } footer: {
                        HStack {
                            Spacer()
                            Text("\(answeredRequests.count) anwsered requests")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                    .accentColor(.green)
                } // List
                .searchable(text: query)
            } // VStack
//            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    SortSelectionView(selectedSortItem: $selectedSort, sorts: RequestSort.sorts)
                        .onChange(of: selectedSort) { _ in
                            let request = requests
//                            request.sectionIdentifier = selectedSort.section
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
// kind of a hacky way to get a NavigationLink in the toolbar
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    HStack {
                        Text("")
                        NavigationLink(destination: AddRequestView()) {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                } // ToolbarItemGroup
            } // toolbar
        } // NavigationView
    } // View

    private func deleteRequest(at offsets: IndexSet) {
        withAnimation {
            offsets.forEach { offset in
                let request = requests[offset]
                coreDataManager.deleteRequest(request: request)
            }
        }
    } // deleteRequest
} // ContentView

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        //        let context = CoreDataManager.preview.container.viewContext
//        ContentView()
//        //            .environment(\.managedObjectContext, context)
//    }
//}
