//
//  MyPrayerJournalWidgetView.swift
//  MyPrayerJournalWidgetExtension
//
//  Created by Scott Bolin on 3-Mar-22.
//

import WidgetKit
import SwiftUI

struct MyPrayerJournalWidgetView : View {
    var entry: MyPrayerJournalWidgetProvider.Entry

    var body: some View {
        ZStack {
            Color(.systemTeal)
            VStack(alignment: .leading, spacing: 0) {
                Text("FOCUS REQUEST")
                    .font(.caption2).bold()
                    .foregroundColor(.pink)
                    .padding(2)
                Divider()
                    .padding(.bottom, 2)
                Text(entry.requestString)
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(.indigo)
                Text(entry.dateRequestedString)
                Text(entry.topicString)
                //                Text(entry.lessonString)
                //                Text(entry.statusString)
                //                Text(entry.answeredString)
                Spacer(minLength: 0)
            }
            .font(.caption)
            .foregroundColor(.gray)
            .padding(6)
            .background(ContainerRelativeShape().fill(.white))
            .padding(8)
        }
    }
}

struct MyPrayerJournalWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        MyPrayerJournalWidgetView(entry: MyPrayerJournalWidgetEntry(date: Date(), request: "A prayer request", dateRequested: Date(), topic: "Topic", lesson: "Lesson", answered: false, statusID: 0))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        MyPrayerJournalWidgetView(entry: MyPrayerJournalWidgetEntry(date: Date(), request: "A prayer request", dateRequested: Date(), topic: "Topic", lesson: "Lesson", answered: false, statusID: 0))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
