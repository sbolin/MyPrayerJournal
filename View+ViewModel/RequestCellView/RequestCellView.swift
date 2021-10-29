//
//  RequestCellView.swift
//  RequestCellView
//
//  Created by Scott Bolin on 5-Oct-21.
//

import SwiftUI

struct RequestCellView: View {
    var coreDataController: CoreDataController = .shared

    @Environment(\.managedObjectContext) private var viewContext
    @State var prayerRequest: PrayerRequest
//
    var isCompleted: Binding<Bool> {
        Binding(
            get: {
                prayerRequest.answered
            },
            set: { isCompleted, transaction in
                withTransaction(transaction) {
                    CoreDataController.shared.updatePrayerCompletion(request: prayerRequest, isCompleted: isCompleted)
                }
            })
    }
    
    var body: some View {
        HStack {
            Toggle("", isOn: isCompleted) // prayerRequest.answered
                .toggleStyle(CheckboxToggleStyle())

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(prayerRequest.requestString)
                    Spacer()
                    Text(prayerRequest.dateRequestedString)
                }
                HStack {
                    Text(prayerRequest.answeredString)
                    Spacer()
                    Text(prayerRequest.prayerTag.first?.tagName ?? "No Tag")
                }
                .font(.caption)
            }
        }

    }
}

struct RequestView_Previews: PreviewProvider {
    static var previews: some View {
        RequestCellView(prayerRequest: .preview)
            .environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: configuration.isOn ? "checkmark.circle" : "circle")
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(configuration.isOn ? .green : .black)
            .onTapGesture { configuration.isOn.toggle() }
    }
}
