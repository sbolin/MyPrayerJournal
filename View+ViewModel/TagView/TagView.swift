//
//  TagView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 1-Nov-21.
//

import SwiftUI

struct TagView: View {
    @ObservedObject var tagViewModel: TagViewModel
    var tag: TagValues
    var fontSize: CGFloat
    var tagTextColor: Color

    // Add geometry effect to tag...
    @Namespace var animation

    var body: some View {
        let tagBGColor = PrayerTag.colorDict[tag.tagColor] ?? .blue
            Text(tag.tagName)
                .font(.system(size: fontSize))
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(Capsule().fill(tagBGColor))
                .foregroundColor(tagTextColor)
                .lineLimit(1)
                .contentShape(Capsule())
            // Delete...
                .contextMenu {
                    Button("Delete") {
                        tagViewModel.tags.remove(at: tagViewModel.getIndex(tag: tag))
                    }
                }
                .matchedGeometryEffect(id: tag.id, in: animation)
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(tagViewModel: TagViewModel(), tag: TagValues(tagColor: 9, tagName: "Swift"), fontSize: 16, tagTextColor: .white)
    }
}
