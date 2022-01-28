//
//  PrayerJournalView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 17-Nov-21.
//

import SwiftUI

struct PrayerJournalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var notificationManager = NotificationManager()
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

    var query: Binding<String> {
        Binding {
            searchText
        } set: { newValue in
            let compoundPredicate = NSPredicate(format: "%K CONTAINS[cd] %@ OR %K CONTAINS[cd] %@ OR %K CONTAINS[cd] %@", #keyPath(PrayerRequest.request), newValue,
                                       #keyPath(PrayerRequest.topic), newValue,
                                       #keyPath(PrayerRequest.lesson), newValue,
                                       #keyPath(PrayerRequest.prayerTags.tagName), newValue)
            searchText = newValue
            requests.nsPredicate = newValue.isEmpty ? nil : compoundPredicate
        }
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack {
                    List {
                        // Focus requests
                        Section {
                            ForEach(focusRequests) { request in
                                ZStack(alignment: .leading) {
                                    NavigationLink(destination: AddRequestView(notificationManager: notificationManager, requestId: request.objectID)) {
                                        EmptyView()
                                    }
                                    .opacity(0)
                                    RequestListCell(request: request)
                                }
//                                NavigationLink {
//                                    AddRequestView(requestId: request.objectID)
//                                } label: {
//                                    RequestListCell(request: request)
//                                } // NavigationLink
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
                                    }
                                }
                            } // ForEach
//                            .onDelete(perform: deleteRequest)
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
                        .listRowSeparator(.hidden)
                        .accentColor(.pink)
                        // Active requests
                        Section {
                            ForEach(activeRequests) { request in
                                ZStack(alignment: .leading) {
                                    NavigationLink(destination: AddRequestView(notificationManager: notificationManager, requestId: request.objectID)) {
                                        EmptyView()
                                    }
                                    .opacity(0)
                                    RequestListCell(request: request)
                                }

//                                NavigationLink {
//                                    AddRequestView(requestId: request.objectID)
//                                } label: {
//                                    RequestListCell(request: request)
//                                } // NavigationLink

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
                                    }
                                }
                            } // ForEach
                              //                            .onDelete(perform: deleteRequest)
                        } header: {
                            Label("Requests", systemImage: "checkmark.circle")
                                .foregroundColor(.blue)
                        } footer: {
                            HStack {
                                Spacer()
                                Text("\(activeRequests.count) Requests Remain")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .listRowSeparator(.hidden)
                        .accentColor(.blue)
                        // Answered requests
                        Section {
                            ForEach(answeredRequests) { request in
                                ZStack(alignment: .leading) {
                                    NavigationLink(destination: AddRequestView(notificationManager: notificationManager, requestId: request.objectID)) {
                                        EmptyView()
                                    }
                                    .opacity(0)
                                    RequestListCell(request: request)
                                }
//                                NavigationLink {
//                                    AddRequestView(requestId: request.objectID)
//                                } label: {
//                                    RequestListCell(request: request)
//                                } // NavigationLink
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
                                    }
                                }
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
                            }
                        }
                        .listRowSeparator(.hidden)
                        .accentColor(.green)
                    } // List
                    .searchable(text: query)
                    .listStyle(.grouped)
                    .onAppear(perform: notificationManager.reloadAuthorizationStatus)
                    .onChange(of: notificationManager.authorizationStatus) { authStatus in
                        switch authStatus {
                        case .notDetermined:
                            notificationManager.requestAuthorization()
                        case .authorized:
                            notificationManager.reloadLocalNotifications()
                        default:
                            break
                        }
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                        notificationManager.reloadAuthorizationStatus()
                    }
//                    .listSectionSeparator(.hidden)
                } // VStack
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
                            Text("Prayer Journal").font(.title2).bold()
                                .foregroundColor(.indigo)
                        }
                    } // ToolbarItemGroup
                } // toolbar

                NavigationLink(destination: AddRequestView(notificationManager: notificationManager)) {
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
            if let identifier = request.id?.uuidString {
                notificationManager.deleteLocalNotifications(identifiers: [identifier])
            }
        }
    } // deleteRequest

    private func completeRequest(request: PrayerRequest) {
        withAnimation {
            let status = !request.answered
            coreDataManager.updatePrayerCompletion(request: request, isCompleted: status, context: viewContext)

            if let identifier = request.id?.uuidString {
                notificationManager.deleteLocalNotifications(identifiers: [identifier])
            }
        }
    } // deleteRequest
} // ContentView

struct PrayerJournalView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerJournalView()
    }
}
