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
                    NavigationLink("Ellipse") { EllipseView() }
                    NavigationLink("Triangle") { TriangleView() }
                    NavigationLink("Shape Modifier") { ShapeView() }
                }

                Section("Advanced") {
                    NavigationLink("Day/Night") { DayNightView() }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
