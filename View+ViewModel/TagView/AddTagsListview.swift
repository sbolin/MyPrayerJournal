//
//  AddTagsListview.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 2-Nov-21.
//

import SwiftUI

struct AddTagsListview: View {

    @ObservedObject var tagViewModel: TagViewModel

    @State var text: String = "" // Textfield text
    @State var showAlert: Bool = false
    var fontSize: CGFloat = 16
    var maxLimit: Int = 10

    var body: some View {
        VStack(spacing: 6) {
            // custom tag view
            AddTagView(maxLimit: 10, fontSize: 16, tagTextColor: Color.secondary, tagViewModel: tagViewModel)
                .frame(height: 100)
                .padding(.top, 20)


            // textfield
            TextField("apple", text: $text)
                .font(.body)
                .padding(.vertical, 6)
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(Color.secondary, lineWidth: 1)
                )
                .padding(.vertical, 20)

            // Add Button...
            Button {
                // adding TagValues...
                tagViewModel.addTag(tags: tagViewModel.tags, text: text, fontSize: fontSize, maxLimit: maxLimit) { alert, tag in
                    if alert {
                        // showing alert
                        showAlert.toggle()
                    } else {
                        tagViewModel.tags.append(tag)
                        text = ""
                    }
                }

            } label: {
                Text("Add Tag")
//                    .fontWeight(.semibold)
            }
            .buttonStyle(.borderedProminent)
            .accentColor(.green)
            .disabled(text == "")


        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.white.ignoresSafeArea())
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Tag Limit Exceeded, please delete some tags"), dismissButton: .destructive(Text("Got it!")))
        }
    }
}

struct AddTagsListview_Previews: PreviewProvider {
    static var previews: some View {
        AddTagsListview(tagViewModel: TagViewModel())
    }
}
