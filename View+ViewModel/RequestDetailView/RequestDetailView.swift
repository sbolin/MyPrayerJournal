//
//  RequestDetailView.swift
//  RequestDetailView
//
//  Created by Scott Bolin on 7-Oct-21.
//

import SwiftUI

struct RequestDetailView: View {

    var prayerRequest: PrayerRequest
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.green)
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(prayerRequest.requestString)
                    Spacer()
                    Text(prayerRequest.dateRequestedString)
                }
                HStack {
                    Text(prayerRequest.answeredString)
                    Spacer()
                    Text(prayerRequest.topicString)
                }
                Text(prayerRequest.prayerTag.first?.tagName ?? "")
                Text("\(Int(prayerRequest.prayerTag.first?.tagColor ?? 0))")
            }
        }
//        .onAppear {
//            viewModel.selectedRequest = nil
//            viewModel.fetchAllTags()
//            viewModel.fetchAllVerses()
//        }
    }
}

struct RequestDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RequestDetailView(prayerRequest: .preview)
            .environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
    }
}
