//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Akshat Gandhi on 24/08/24.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
