//
//  TagColorSelectorView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 1-Dec-21.
//

import SwiftUI

struct TagColorSelectorView: View {
    @Binding var selectedColor: Color
    let colors: [Color] = [.red, .orange, .yellow, .green, .cyan, .blue, .purple, .indigo]

    var body: some View {
        HStack {
            Text("Color")
                .fixedSize()
                .foregroundColor(.secondary)
            ForEach(colors, id: \.self) { color in
                Image(systemName: selectedColor == color ? "record.circle.fill" : "circle.fill")
                    .font(.title)
                    .foregroundColor(color)
                    .clipShape(Circle())
                    .onTapGesture {
                        selectedColor = color
                    }
            }
        }
        .padding(.bottom)
    }
}

struct TagColorSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        TagColorSelectorView(selectedColor: .constant(.blue))
    }
}
