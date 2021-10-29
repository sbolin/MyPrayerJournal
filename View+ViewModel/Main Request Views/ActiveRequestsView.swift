//
//  RequestsView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 20-Oct-21.
//

/*
import SwiftUI

struct ActiveRequestsView: View {
    var coreDataController: CoreDataController = .shared

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: PrayerRequest.fetchRequest())
    private var prayers: FetchedResults<PrayerRequest>
    
    var body: some View {
        HeaderView(title: "Active Request", color: Color(UIColor.systemMint))
        ForEach(prayers) { prayer in
            NavigationLink(destination: RequestDetailView(viewModel: RequestDetailViewModel(prayerRequest: prayer))) {
                RequestCellView(prayerRequest: prayer)
            }
        }
        .onDelete(perform: deleteItems)
        .onMove(perform: onMove)
        FooterView(title: "Active Requests", count: prayers.count)
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

    private func onMove(from source: IndexSet, to destination: Int) {
 //       requests.move(fromOffsets: source, toOffset: destination)
    }

}

struct RequestsView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveRequestsView()
            .environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
    }
}
*/
