//
//  AddTagView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 1-Nov-21.
//

import SwiftUI

struct AddTagView: View {

    var maxLimit: Int
    var title: String = "Add Tags:"
    var fontSize: CGFloat = 16
    var tagTextColor: Color
    @ObservedObject var tagViewModel: TagViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.callout)
                .foregroundColor(Color.secondary)
            //ScrollView
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(tagViewModel.getRows(), id: \.self) { rows in
                        HStack(spacing: 6) {
                            ForEach(rows) { row in
                                TagView(tagViewModel: tagViewModel, tag: row, fontSize: fontSize, tagTextColor: tagTextColor)
                            }
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 80, alignment: .leading)
                .padding(.vertical)
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(Color.secondary.opacity(0.15), lineWidth: 1))
            // Animation
            .animation(.easeInOut, value: tagViewModel.tags)
            .overlay(
                Text("\(tagViewModel.getSize(tags: tagViewModel.tags))/\(maxLimit)")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color.secondary)
                    .padding(12),
                alignment: .bottomTrailing
            )
        }
    }
}

struct AddTagView_Previews: PreviewProvider {
    static var previews: some View {
        AddTagView(maxLimit: 10, fontSize: 16, tagTextColor: Color.secondary, tagViewModel: TagViewModel())
    }
}
