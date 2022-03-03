//
//  MyPrayerJournalWidgetEntry.swift
//  MyPrayerJournalWidgetExtension
//
//  Created by Scott Bolin on 3-Mar-22.
//

import SwiftUI
import WidgetKit

struct MyPrayerJournalWidgetEntry: TimelineEntry {
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

    var lesson: String?
    var lessonString: String {
        return lesson ?? ""
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
