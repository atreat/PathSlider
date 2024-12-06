//
//  ExamplesApp.swift
//  Examples
//
//  Created by Austin Emmons on 11/26/24.
//

import SwiftUI

@main
struct ExamplesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 300, minHeight: 600)
        }.windowResizability(.contentMinSize)
    }
}
