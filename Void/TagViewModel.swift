//
//  TagViewModel.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 1-Nov-21.
//

import SwiftUI

// not used, will be incorporated in the view
/*

class TagViewModel: ObservableObject {
    @Published var tags: [PrayerTag] = []

    func addTag(tags: [PrayerTag], text: String, fontSize: CGFloat, maxLimit: Int, completion: @escaping (Bool, PrayerTag) -> ()) {
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: attributes) // size of text in tag

        let tag = TagValues(tagColor: 1, tagName: text, tagSize: size.width)
        if getSize(tags: tags) < maxLimit { // text.count
            completion(false, tag)
        } else {
            completion(true, tag)
        }
    }

    func getSize(tags: [PrayerTag]) -> Int {
        // for counting the text in the tags. If only counting tags: return tags.count
        //        var count: Int = 0
        //        tags.forEach { tag in
        //            count += tag.text.count
        //        }
        //        return count
        return tags.count
    }

    func getIndex(tag: PrayerTag) -> Int {
        let index = tags.firstIndex { currentTag in
            return tag.id == currentTag.id
        } ?? 0
        return index
    }

    // Basic logic of tag view
    // splitting the array when it exceeds the screen size...
    func getRows() -> [[TagValues]] {
        var rows: [[TagValues]] = []
        var currentRow: [TagValues] = []

        // calculate text width...
        var totalWidth: CGFloat = 0

        // screen width, extra 5 for safety
        let screenWidth: CGFloat = UIScreen.main.bounds.width - 85

        tags.forEach { tag in
            // must include capsule size and spacing into totalWidth
            // 14 + 14 + 6
            totalWidth += (tag.tagSize + 34) // 40

            if totalWidth > screenWidth {
                // adding row in rows...
                // clearing the data
                // check for long string
                totalWidth = (!currentRow.isEmpty || rows.isEmpty ? (tag.tagSize + 34) : 0) // 40
                rows.append(currentRow)
                currentRow.removeAll()
                currentRow.append(tag)

            } else {
                currentRow.append(tag)
            }
        }

        // check if have any value store it in row
        if !currentRow.isEmpty {
            rows.append(currentRow)
            currentRow.removeAll()
        }
        return rows
    }
}
*/
