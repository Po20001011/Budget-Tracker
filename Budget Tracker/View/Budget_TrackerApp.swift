//
//  Budget_TrackerApp.swift
//  Budget Tracker
//
//  Created by Wang Po on 10/8/2023.
//

import SwiftUI

@main
struct YourApp: App {
    var body: some Scene {
        WindowGroup {
           AppTabView()
                .preferredColorScheme(.light)
        }
    }
}
