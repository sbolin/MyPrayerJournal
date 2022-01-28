//
//  FooterView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 20-Oct-21.
//

import SwiftUI

struct FooterView: View {
    var title: String
    var count: Int

    var body: some View {
        ListRow {
            Text("\(title) \(count)")
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.subheadline)
        }
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView(title: "Footer Title", count: 4)
    }
}
