//
//  HighlistTextField.swift
//  MyPrayerJournal (iOS)
//
//  Created by Scott Bolin on 2-Feb-22.
//
// see: https://stackoverflow.com/questions/67502138/select-all-text-in-textfield-upon-click-swiftui

import UIKit
import SwiftUI

struct HighlightTextField: UIViewRepresentable {

    @Binding var text: String

    func makeUIView(context: Context) -> UITextView { // UITextField
        let textField = UITextView() // UITextField()
        textField.delegate = context.coordinator as? UITextViewDelegate
        return textField
    }

    func updateUIView(_ textField: UITextView, context: Context) { // UITextField
        textField.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: HighlightTextField

        init(parent: HighlightTextField) {
            self.parent = parent
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.endOfDocument)
        }

        func textFieldDidBeginEditing(_ textField: UITextField) { // UITextField
            textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
        }
    }
}
