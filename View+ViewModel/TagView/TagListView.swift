//
//  TagListView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 3-Dec-21.
//

import SwiftUI

struct TagListView: View {
    var request: PrayerRequest
    var allTags: Set<PrayerTag>
    var groupedTags = [[PrayerTag]]()
    let screenWidth = UIScreen.main.bounds.width
    var maxLimit: Int = 10

    // need to change this to Tag object...
    init(request: PrayerRequest) {
        self.request = request
        self.allTags = request.prayerTag
        self.groupedTags = createGroupedItems(request)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Add Tags...")
                .font(.callout)
                .foregroundColor(.secondary)

            // Scrollview of all tags
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(groupedTags, id: \.self) { rows in
                        HStack(spacing: 8) {
                            ForEach(rows, id: \.self) { tag in
                                TagView(tag: tag, fontSize: 16)
                            } // ForEach
                        } // HStack
                    } // ForEach
                } // VStack
                .frame(width: screenWidth - 40, alignment: .leading)
                .padding(.vertical)
                //                .padding(.bottom, 20)
            } // ScrollView
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 6).strokeBorder(Color.secondary, lineWidth: 1))
            // Animation
            .animation(.easeInOut, value: groupedTags)
            .overlay(
                Text("\(allTags.count)/\(maxLimit)")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.secondary)
                    .padding(12),
                alignment: .bottomTrailing
            )
        } // VStack
    }

    private func createGroupedItems(_ request: PrayerRequest) -> [[PrayerTag]] {
// need to get tags from
        var rows = [[PrayerTag]]()
        var currentRow = [PrayerTag]()
        // calculate text width...
        var totalWidth: CGFloat = 0

        // screen width, extra 5 for safety
        let screenWidth: CGFloat = UIScreen.main.bounds.width - 32

        let font = UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font]

        let tags = request.prayerTag

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

struct TagListView_Previews: PreviewProvider {
    static var previews: some View {
        TagListView(request: PrayerRequest())
    }
}
