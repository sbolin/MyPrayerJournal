//
//  TagRowView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 4-Dec-21.
//

import SwiftUI

struct TagRowView: View {
    var tags: Set<PrayerTag>
    var groupedTags = [[PrayerTag]]()
    let screenWidth = UIScreen.main.bounds.width
    var maxLimit: Int = 10
    var fontSize: CGFloat

    // need to change this to Tag object...
    init(tags: Set<PrayerTag>, fontSize: CGFloat) {
        self.tags = tags
        self.fontSize = fontSize
        self.groupedTags = createGroupedItems(tags)
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(groupedTags, id: \.self) { rows in
                    HStack(spacing: 8) {
                        ForEach(rows, id: \.self) { tag in
                            TagView(tag: tag, fontSize: fontSize)
                        } // ForEach
                    } // HStack
                } // ForEach
            } // VStack
        } // ScrollView
    }

    private func createGroupedItems(_ tags: Set<PrayerTag>) -> [[PrayerTag]] {
        var rows = [[PrayerTag]]()
        var currentRow = [PrayerTag]()
        // calculate text width...
        var totalWidth: CGFloat = 0

        // screen width, extra 5 for safety
        let screenWidth: CGFloat = UIScreen.main.bounds.width - 32

        let font = UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font]

        tags.forEach { tag in
            // must include capsule size and spacing into totalWidth
            // 14 + 14 + 6
            let size = (tag.tagNameString as NSString).size(withAttributes: attributes) // size of text in tag
            totalWidth += (size.width + 32)
            if totalWidth > screenWidth {
                // adding row in rows...
                // clearing the data
                // check for long string
                totalWidth = (!currentRow.isEmpty || rows.isEmpty ? (size.width + 32) : 0)
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

struct TagRowView_Previews: PreviewProvider {
    static var previews: some View {
        TagRowView(tags: Set<PrayerTag>(), fontSize: 12)
    }
}
