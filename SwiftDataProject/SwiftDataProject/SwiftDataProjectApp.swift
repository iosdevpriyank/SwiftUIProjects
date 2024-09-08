//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Akshat Gandhi on 28/08/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
