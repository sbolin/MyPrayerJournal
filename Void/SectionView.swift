//
//  SectionView.swift
//  Shared
//
//  Created by Scott Bolin on 6-Sep-21.
//

import SwiftUI
import CoreData

/*
struct PrayerJournalView: View {
    @Environment(\.managedObjectContext) var moc

    @State private var selectedSort = SelectedSort()
    @SectionedFetchRequest(sectionIdentifier: \PrayerRequest.answeredString,
        sortDescriptors: [SortDescriptor(\PrayerRequest.dateRequested, order: .forward)],
        animation: .default)
    private var prayerRequests: SectionedFetchResults<String, PrayerRequest>

    @State private var searchText = ""
    var query: Binding<String> {
        Binding {
            searchText
        } set: { newValue in
            searchText = newValue
            prayerRequests.nsPredicate = newValue.isEmpty ? nil : NSPredicate(format: "prayer CONTAINS %@", newValue)
        }
    }

    let sorts = [
        (sortName: "Answered", sortDescriptor: [SortDescriptor(\PrayerRequest.answered, order: .reverse)],
         sortSection: \PrayerRequest.answered),
        (sortName: "Answered", sortDescriptor: [SortDescriptor(\PrayerRequest.answered, order: .forward)], sortSection: \PrayerRequest.answered),
        (sortName: "Date", sortDescriptor: [SortDescriptor(\PrayerRequest.date, order: .reverse)], sortSection: \PrayerRequest.date),
        (sortName: "Date", sortDescriptor: [SortDescriptor(\PrayerRequest.date, order: .forward)], sortSection: \PrayerRequest.date)
    ] as [KeyPath<PrayerRequest, String>]

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(prayerRequests) { section in
                        Section(header: Text("\(section.id)")) {
                            ForEach(section, id: \.self) { prayer in
                                Text(prayer.prayer ?? "")
                            }
                        }
                    }
                    .onDelete(perform: removeRequest)
                }

                Button("Add prayer request") {
                    // for now just add a dummy request, later this will navigate to a new view.
                    let request = PrayerRequest(context: moc)
                    request.prayer = "Request \(1)"
                    request.topic = "Topic \(1)"
                    request.dateRequested = Date()
                    request.answered = false
                    CoreDataController.shared.save()
                }
                .buttonStyle(.borderless)
            }
            .navigationTitle("Requests")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    SortMenu(selection: $selectedSort)
                        .onChange(of: selectedSort) { _ in
                            let sortBy = sorts[selectedSort.index]
                            let config = prayerRequests
                            config.sectionIdentifier = sortBy
                            prayerRequests.sortDescriptors = sortBy.descriptors
                        }
                }
            }
        }
    }

    struct SelectedSort: Equatable {
        var by = 0
        var order = 0
        var index: Int { by + order }
    }

    struct SortMenu: View {
        @Binding private var selectedSort: SelectedSort

        init(selection: Binding<SelectedSort>) {
            _selectedSort = selection
        }

        var body: some View {
            Menu {
                Picker("Sort By", selection: $selectedSort.by) {
                    ForEach(Array(stride(from: 0, to: sorts.count, by: 2)), id: \.self) { index in
                        Text(sorts[index].name).tag(index)
                    }
                }
                Picker("Sort Order", selection: $selectedSort.order) {
                    let sortBy = sorts[selectedSort.by + selectedSort.order]
                    let sortOrders = sortOrders(for: sortBy.name)
                    ForEach(0..<sortOrders.count, id: \.self) { index in
                        Text(sortOrders[index]).tag(index)
                    }
                }
            } label: {
                Label("More", systemImage: "ellipsis.circle")
            }
            .pickerStyle(InlinePickerStyle())
        }

        private func sortOrders(for name: String) -> [String] {
            switch name {
            case "Magnitude":
                return ["Highest to Lowest", "Lowest to Highest"]
            case "Time":
                return ["Newest on Top", "Oldest on Top"]
            default:
                return []
            }
        }
    }

    private func removeRequest(at offsets: IndexSet) {
        for index in offsets {
            let prayer = prayerRequests
            let requestToRemove = prayerRequests[index]
            moc.delete(requestToRemove)

        }
        CoreDataController.getAllRequests
    }
}


struct ContentView_Previews: PreviewProvider {
    static let requests = CoreDataController.preview
    static var previews: some View {
        PrayerJournalView()
            .environment(\.managedObjectContext, requests.viewContext)
    }
}
*/
