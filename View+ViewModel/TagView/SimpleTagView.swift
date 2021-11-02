//
//  SimpleTagView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 2-Nov-21.
//

import SwiftUI

struct SimpleTagView: View {
    var text: String
    var fontSize: CGFloat
    var tagTextColor: Color
    var tagBGColor: Color

    // Add geometry effect to tag...
    @Namespace var animation

    var body: some View {
        Text(text)
            .font(.system(size: fontSize))
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(Capsule()
                            .fill(tagBGColor))
            .foregroundColor(tagTextColor)
            .lineLimit(1)
            .contentShape(Capsule())
        // Delete...
//            .contextMenu {
//                Button("Delete") {
//                    tagViewModel.tags.remove(at: tagViewModel.getIndex(tag: tag))
//                }
//            }
//            .matchedGeometryEffect(id: tag.id, in: animation)
    }
}

struct SimpleTagView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleTagView(text: "Swift", fontSize: 16, tagTextColor: Color.white, tagBGColor: Color.blue)
    }
}
