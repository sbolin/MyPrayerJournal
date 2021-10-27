//
//  RequestDetailView.swift
//  RequestDetailView
//
//  Created by Scott Bolin on 7-Oct-21.
//

import SwiftUI

struct RequestDetailView: View {

    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var viewModel: RequestDetailViewModel
    var tags: [PrayerTag] = []
    var verses: [PrayerVerse] = []
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.green)
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(viewModel.prayerRequest.requestString)
                    Spacer()
                    Text(viewModel.prayerRequest.dateRequestedString)
                }
                HStack {
                    Text(viewModel.prayerRequest.answeredString)
                    Spacer()
                    Text(viewModel.prayerRequest.topicString)
                }
                Text(viewModel.allTagsForRequest.first?.tagName ?? "No tag")
                Text(viewModel.allVersesForRequest.first?.verseNameString ?? "No verse")
            }
        }
        .onAppear {
            viewModel.selectedRequest = nil
//            viewModel.fetchAllTags()
//            viewModel.fetchAllVerses()
        }
    }
}

struct RequestDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RequestDetailView(viewModel: RequestDetailViewModel(prayerRequest: PrayerRequest(context: CoreDataController.preview.container.viewContext)))
            .environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
    }
}
