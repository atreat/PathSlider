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
                NavigationLink("Ellipse") { EllipseView() }
            }
        }
    }
}

#Preview {
    ContentView()
}
