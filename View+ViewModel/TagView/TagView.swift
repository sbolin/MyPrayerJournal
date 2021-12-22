//
//  TagView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 1-Nov-21.
//

import SwiftUI

struct TagView: View {
    var tag: PrayerTag
    var fontSize: CGFloat

    // Add geometry effect to tag...
    @Namespace var animation

    var body: some View {
        Text(tag.tagNameString)
            .fixedSize(horizontal: true, vertical: false)
            .font(.system(size: fontSize))
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(Capsule().fill(tag.tagColor.opacity(0.75)))
            .foregroundColor(Color.white) // not sure about this...
            .lineLimit(1)
            .contentShape(Capsule())
        // Delete...
            .contextMenu {
                Button("Delete") {
// delete tag from core data
                }
            }
            .matchedGeometryEffect(id: tag, in: animation)
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(tag: PrayerTag(), fontSize: 12)
    }
}
