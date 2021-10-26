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
                .foregroundColor(.white)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Title", color: Color(UIColor.systemMint))
    }
}
