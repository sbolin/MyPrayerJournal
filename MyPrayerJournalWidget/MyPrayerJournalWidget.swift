//
//  MyPrayerJournalWidget.swift
//  MyPrayerJournalWidget
//
//  Created by Scott Bolin on 24-Dec-21.
//

import CoreData
import WidgetKit
import SwiftUI

@main
struct MyPrayerJournalWidget: Widget {
    let kind: String = "MyPrayerJournalWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MyPrayerJournalWidgetProvider()) { entry in
            MyPrayerJournalWidgetView(entry: entry)
                .environment(\.managedObjectContext, CoreDataController.shared.container.viewContext)
        }
        .configurationDisplayName("MyPrayerJournal")
        .description("MyPrayerJournal widget displays your focused prayer request in a widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct MyPrayerJournalWidget_Previews: PreviewProvider {
    static var previews: some View {
        MyPrayerJournalWidgetView(entry: MyPrayerJournalWidgetEntry(date: Date(), request: "A prayer request", dateRequested: Date(), topic: "Topic", lesson: "Lesson", answered: false, statusID: 0))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        MyPrayerJournalWidgetView(entry: MyPrayerJournalWidgetEntry(date: Date(), request: "A prayer request", dateRequested: Date(), topic: "Topic", lesson: "Lesson", answered: false, statusID: 0))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
