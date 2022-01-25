//
//  TagView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 1-Nov-21.
//

import SwiftUI

struct TagView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let coreDataManager: CoreDataController = .shared
    var tag: PrayerTag
    var fontSize: CGFloat

    // Add geometry effect to tag...
    @Namespace var animation

    var body: some View {
        HStack(spacing: 6) {
            Text(tag.tagNameString)
                .fixedSize(horizontal: true, vertical: false)
                .font(.system(size: fontSize))
                .lineLimit(1)
            Button {
                coreDataManager.deleteTag(tag: tag, context: viewContext)
            } label: {
                Image(systemName: "x.circle")
                    .renderingMode(.original)
                    .font(.system(size: fontSize + 2))
            }
            .matchedGeometryEffect(id: tag, in: animation)
        }
        .padding(.leading, 12)
        .padding(.trailing, 6)
        .padding(.vertical, 6)
        .background(Capsule().fill(tag.tagColor.opacity(0.75)))
        .foregroundColor(Color.white) // not sure about this...
        .contentShape(Capsule())
    }
}

//struct TagView_Previews: PreviewProvider {
//    static var previews: some View {
//        TagView(tag: PrayerTag(), fontSize: 11)
//    }
//}
