//
//  OnboardingView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 15-Mar-22.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var shouldShowOnboarding: Bool

    var body: some View {
        TabView {
            PageView(
                imageName: "bell",
                title: "Push Notification",
                subtitle: "Enable notifications to stay up to date with our app.", background: .red,
                showDismissButton: false,
                shouldShowOnboarding: $shouldShowOnboarding)

            PageView(
                imageName: "bookmark",
                title: "Bookmarks",
                subtitle: "Save bookmarks for future reference.", background: .green,
                showDismissButton: false,
                shouldShowOnboarding: $shouldShowOnboarding)

            PageView(
                imageName: "airplane",
                title: "Flightts",
                subtitle: "Book flights to the places you want to go", background: .blue,
                showDismissButton: false,
                shouldShowOnboarding: $shouldShowOnboarding)

            PageView(
                imageName: "house",
                title: "Home",
                subtitle: "Go home wherever you might be",
                background: .purple,
                showDismissButton: true,
                shouldShowOnboarding: $shouldShowOnboarding)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(shouldShowOnboarding: .constant(true))
    }
}
