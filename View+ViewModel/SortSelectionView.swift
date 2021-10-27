//
//  SortSelectionView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 28-Oct-21.
//

import SwiftUI

struct SortSelectionView: View {
    @Binding var selectedSortItem: RequestSort
    let sorts: [RequestSort]

    var body: some View {
        Menu {
            Picker("Sort By", selection: $selectedSortItem) {
                ForEach(sorts, id: \.self) { sort in
                    Text("\(sort.name)")
                }
            }
        } label: {
            Label("Sort", systemImage: "line.horizontal.3.decrease.circle")
        }
        .pickerStyle(.inline)
    }
}


struct SortSelectionView_Previews: PreviewProvider {
    @State static var sort = RequestSort.default
    static var previews: some View {
        SortSelectionView(selectedSortItem: $sort, sorts: RequestSort.sorts)
    }
}
