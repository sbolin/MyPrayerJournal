//
//  PendingRequestsView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 20-Oct-21.
//

import SwiftUI

struct PendingRequestsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: PrayerRequest.fetchRequest())
    private var prayers: FetchedResults<PrayerRequest>

    var body: some View {
        HeaderView(title: "Pending Request", color: Color(UIColor.systemPink).opacity(0.4))
        ForEach(prayers) { prayer in
            NavigationLink(destination: RequestDetailView(viewModel: RequestDetailViewModel(prayerRequest: prayer))) {
                RequestCellView(prayerRequest: prayer)
            }
        }
        .onDelete(perform: deleteItems)
        .onMove(perform: moveItems)
        FooterView(title: "Pending Requests", count: prayers.count)
    }

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

    private func moveItems(from source: IndexSet, to destination: Int) {
        //       requests.move(fromOffsets: source, toOffset: destination)
    }

}

struct PendingRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        PendingRequestsView().environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
    }
}
