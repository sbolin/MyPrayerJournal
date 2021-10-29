//
//  FocusPrayerView.swift
//  FocusPrayerView
//
//  Created by Scott Bolin on 5-Oct-21.
//

import SwiftUI

/*
struct FocusPrayerView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var prayerRequest: PrayerRequest?

    var body: some View {
        VStack {

            if let request = prayerRequest {
                VStack(spacing: 6) {
                    Text("Current Prayer")
                        .font(.caption)
//                  RequestCellView(prayerRequest: request)
                    VStack(alignment: .leading) {

                        HStack {
                            Text(request.requestString)
                                .font(.title2)
                            Spacer()
                        }
                        Text(request.topicString)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            } else {
                Text("Drag Current Request Here")
            }
        }
        .frame(maxWidth: .infinity, minHeight: 80)
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
                .background(Color.indigo.opacity(0.10)).clipShape(RoundedRectangle(cornerRadius: 15)))
    }
}

struct FocusRequestView_Previews: PreviewProvider {
    static var previews: some View {
        FocusPrayerView(prayerRequest: PrayerRequest(context: CoreDataController.preview.container.viewContext))
//            .environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
    }
}
*/
