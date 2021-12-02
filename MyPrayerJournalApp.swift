//
//  MyPrayerJournalApp.swift
//  Shared
//
//  Created by Scott Bolin on 6-Sep-21.
//

import SwiftUI

@main
struct MyPrayerJournalApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            PrayerJournalView()
//            ContentView()
                .environment(\.managedObjectContext, CoreDataController.shared.container.viewContext)
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
                .onChange(of: scenePhase) { _ in
                    CoreDataController.shared.save()
                }
        }
    }
}
