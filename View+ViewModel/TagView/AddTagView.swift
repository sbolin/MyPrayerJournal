//
//  AddTagView.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 1-Nov-21.
//

import SwiftUI

struct AddTagView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @Binding var prayerTags: Set<PrayerTag>

    @State var text: String = "" // Tag name text
    @State var showAlert: Bool = false
    @State var tagBGColor: Color = .cyan // Tag background color
    let maxLimit = 10

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Current Tags")
                .font(.callout)
                .foregroundColor(.secondary)
            // List of tags
            TagListView(tags: prayerTags, fontSize: 12)
                .frame(height: 125)
//                .fixedSize()

            Text("Add Tags...")
                .font(.callout)
                .foregroundColor(.secondary)
                .padding(.top)
            // textfield
            TextField("Tag name", text: $text)
                .textFieldStyle(.roundedBorder)
//                .font(.title2)
                .padding(.bottom)
                .frame(width: 300)

            // Get tag color...
            TagColorSelectorView(selectedColor: $tagBGColor)
                .padding(.bottom)
                .frame(width: 300)

            Button {
                // Need to add tags to model
                let newTag = PrayerTag(context: viewContext)
                newTag.tagName = text
                newTag.color = UIColor(tagBGColor)
                prayerTags.insert(newTag)
            } label: {
                Text("Add Tag")
                    .fontWeight(.semibold)
                    .frame(width: 80, height: 32)
            }
            .buttonStyle(.bordered)
            .tint(tagBGColor)
            .disabled(text == "")
            .frame(maxWidth: .infinity, alignment: .center)
            Spacer()
        }
        .padding(.horizontal)
    }
}


struct AddTagView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            Section(header: Text("Tags")) {
                AddTagView(prayerTags: .constant(Set<PrayerTag>()))
            }
        }
    }
}
