//
//  ContentView.swift
//  Examples
//
//  Created by Austin Emmons on 11/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Simple") {
                    NavigationLink("Ellipse") { EllipseView().frame(maxWidth: 350, maxHeight: 600) }
                    NavigationLink("Triangle") { TriangleView().frame(maxWidth: 350, maxHeight: 600) }
                    NavigationLink("Shape Modifier") { ShapeView().frame(maxWidth: 350, maxHeight: 600) }
                }

                Section("Advanced") {
                    NavigationLink("Day/Night") { DayNightView().frame(maxWidth: 350, maxHeight: 600) }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
