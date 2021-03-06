//
//  Font+Rounded.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 2-Feb-22.
//
// Thanks to Peter Friese for this extension
/* https://github.com/peterfriese/MakeItSo/tree/develop?utm_campaign=Not%20Only%20Swift%20Weekly&utm_medium=email&utm_source=Revue%20newsletter
 */
//

import SwiftUI

extension UIFontDescriptor {
    static func largeTitle() -> UIFontDescriptor? {
        UIFontDescriptor.preferredFontDescriptor(withTextStyle: .largeTitle).withSymbolicTraits(.traitBold)
    }

    static func regularTitle() -> UIFontDescriptor? {
        UIFontDescriptor.preferredFontDescriptor(withTextStyle: .title1).withSymbolicTraits(.traitBold)
    }

    static func body() -> UIFontDescriptor? {
        UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).withSymbolicTraits(.traitUIOptimized)
    }

    static func headline() -> UIFontDescriptor? {
        UIFontDescriptor.preferredFontDescriptor(withTextStyle: .headline).withSymbolicTraits(.traitBold)
    }

    func rounded() -> UIFontDescriptor? {
        self.withDesign(.rounded)
    }
}

// see https://gist.github.com/darrensapalo/bd6dddab6a70ae0a2d6cf8ac5aeb6b1a for more
extension UIFont {
    static func roundedLargeTitle() -> UIFont? {
        guard let descriptor = UIFontDescriptor.largeTitle()?.rounded() else { return nil }
        return UIFont(descriptor: descriptor, size: 0)
    }

    static func roundedTitle() -> UIFont? {
        guard let descriptor = UIFontDescriptor.regularTitle()?.rounded() else { return nil }
        return UIFont(descriptor: descriptor, size: 0)
    }

    static func roundedHeadline() -> UIFont? {
        guard let descriptor = UIFontDescriptor.headline()?.rounded() else { return nil }
        return UIFont(descriptor: descriptor, size: 0)
    }

    static func roundedBody() -> UIFont? {
        guard let descriptor = UIFontDescriptor.body()?.rounded() else { return nil }
        return UIFont(descriptor: descriptor, size: 0)
    }
}

extension View {
}

