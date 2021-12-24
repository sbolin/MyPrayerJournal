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
    @State var tagBGColor: Color = .green // Tag background color
    let maxLimit = 6

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {

            Text("ADD TAGS...")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top)
            // textfield
            TextField("Tag name", text: $text)
                .textFieldStyle(.roundedBorder)
            //                .font(.title2)
                .padding(.bottom)

            // Get tag color...
            TagColorSelectorView(selectedColor: $tagBGColor)
                .padding(.bottom)

            Text("CURRENT TAGS")
                .font(.caption)
                .foregroundColor(.secondary)
            // List of tags
            TagListView(tags: prayerTags, fontSize: 12)
                .frame(height: 100)
            HStack {
                Spacer()
                Button {
                    let newTag = PrayerTag(context: viewContext)
                    newTag.tagName = text
                    newTag.color = UIColor(tagBGColor)
                    prayerTags.insert(newTag)
                    text = ""
                } label: {
                    Text("Add Tag")
                }
                .buttonStyle(.bordered)
                .tint(tagBGColor)
            .disabled(text == "")
                Spacer()
            }
            .padding(.top)
        } // vstack
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
