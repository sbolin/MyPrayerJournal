//
//  MyPrayerJournalWidget.swift
//  MyPrayerJournalWidget
//
//  Created by Scott Bolin on 24-Dec-21.
//

import CoreData
import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {

    let snapshotEntry = SimpleEntry(date: Date(), request: "A Prayer Request", dateRequested: Date().addingTimeInterval(-1 * 60 * 60 * 24), topic: "A Prayer Topic", answered: false, statusID: 1)

    func placeholder(in context: Context) -> SimpleEntry {
       return snapshotEntry
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        return completion(snapshotEntry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // get core data
        let moc = CoreDataController.shared.container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PrayerRequest")
        var results = [PrayerRequest]()

        do {
            results = try moc.fetch(request) as! [PrayerRequest]
        } catch {
            print("Could not fetch \(error.localizedDescription)")
        }

        let focusItems = results.filter { $0.focused == true }
        guard let focusItem = focusItems.first else { return }

        let prayerRequest = focusItem.request
        let dateRequested = focusItem.dateRequested
        let topic = focusItem.topic
        let answered = focusItem.answered
        let statusID = focusItem.statusID

        let entry = SimpleEntry(date: Date(), request: prayerRequest, dateRequested: dateRequested, topic: topic, answered: answered, statusID: statusID)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    var request: String?
    var requestString: String {
        return request ?? "No Focus Request"
    }

    var dateRequested: Date?
    var dateRequestedString: String {
        return dateFormatter.string(from: dateRequested ?? Date())
    }

    var topic: String?
    var topicString: String {
        return topic ?? "No Topic"
    }

    var answered: Bool
    var answeredString: String {
        return answered ? "Answered Prayer" : "Unanswered Prayer"
    }

    var statusID: Int16?
    var statusString: String {
        switch statusID {
        case 0: return "Focused"
        case 1: return "Unanswered Prayer"
        case 2: return "Answered Prayer"
        default: return "Unanswered Prayer"
        }
    }

    // set date format for sections...
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, y"
        return formatter
    }
}

struct MyPrayerJournalWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Color(.systemTeal)
            VStack(alignment: .leading, spacing: 0) {
                Text("FOCUS REQUEST:")
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
                Text(entry.statusString)
                Text(entry.answeredString)
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

@main
struct MyPrayerJournalWidget: Widget {
    let kind: String = "MyPrayerJournalWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MyPrayerJournalWidgetEntryView(entry: entry)
                .environment(\.managedObjectContext, CoreDataController.shared.container.viewContext)
        }
        .configurationDisplayName("MyPrayerJournal")
        .description("MyPrayerJournal widget displays your focused prayer request in a widget.")
    }
}

struct MyPrayerJournalWidget_Previews: PreviewProvider {
    static var previews: some View {
        MyPrayerJournalWidgetEntryView(entry: SimpleEntry(date: Date(), request: "A prayer request", dateRequested: Date(), topic: "A topic", answered: false, statusID: 0))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
