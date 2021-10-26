//
//  ListRow.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 20-Oct-21.
//

import SwiftUI

// MARK: - Row

/// A wrapper view that will make the content look like a row within a `List` when the `applyListAppearance` `EnvironmentValue` is set.
///
/// This view is used in this tutorial to keep a consistent UI when demonstrating capabilities using either `List` or `ScrollView`.
struct ListRow<Content: View, Background: View>: View {
    private let content: () -> Content
    private let background: () -> Background

    @Environment(\.applyListAppearance) var applyListAppearance

    init(
        @ViewBuilder background: @escaping () -> Background,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.background = background
        self.content = content
    }

    init(backgroundColor: Color = .white, @ViewBuilder content: @escaping () -> Content) where Background == Color {
        self.init(background: { backgroundColor }, content: content)
    }

    var body: some View {
        if applyListAppearance {
            content()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .background(background())
        } else {
            content()
                .listRowBackground(background())
        }
    }
}

// MARK: - Environment
private struct ApplyListAppearanceKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    var applyListAppearance: Bool {
        get { self[ApplyListAppearanceKey.self] }
        set { self[ApplyListAppearanceKey.self] = newValue }
    }
}
