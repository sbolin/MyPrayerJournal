//
//  PageView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 16-Mar-22.
//

import SwiftUI

struct PageView: View {
    let imageName: String
    let title: String
    let subtitle: String
    let background: Color
    let showDismissButton: Bool
    @Binding var shouldShowOnboarding: Bool

    var body: some View {

        VStack(spacing: 0) {
            Image(systemName: imageName)
                .renderingMode(.template)
                .font(.system(size: 150, weight: .light))
                .foregroundColor(.white)
                .padding()
            Text(title)
                .font(.system(size: 32))
                .padding()
            Text(subtitle)
                .font(.system(size: 24))
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white.opacity(0.7))
                .padding()
            if showDismissButton {
                Button {
                    shouldShowOnboarding.toggle()
                } label: {
                    Text("Let's Get Started!")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(background)
                        .cornerRadius(6)
                }
            }
        }
        .frame(width: 350, height: 450)
        .background(background.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding()
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(imageName: "bell", title: "Push Notification", subtitle: "Enable notifications to stay up to date with our app", background: .blue, showDismissButton: false, shouldShowOnboarding: .constant(true))
    }
}
