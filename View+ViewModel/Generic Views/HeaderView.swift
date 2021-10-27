//
//  HeaderView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 20-Oct-21.
//

import SwiftUI

struct HeaderView: View {
    var title: String
    var color: Color

    var body: some View {
        ListRow(backgroundColor: color) {
            Text(title)
                .font(.title2)
                .foregroundColor(.gray) // change to .white
                .frame(maxWidth: .infinity, alignment: .leading)

        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Title", color: Color(UIColor.systemMint))
    }
}
