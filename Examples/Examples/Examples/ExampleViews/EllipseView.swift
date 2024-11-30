//
//  EllipseView.swift
//  Examples
//
//  Created by Austin Emmons on 11/26/24.
//

import SwiftUI
import PathSlider

struct EllipseView: View {

    @State var dragPoint: CGPoint = .zero
    @State var value: Float = 0.5


    var body: some View {
        let path = Path(
            ellipseIn: CGRect(origin: .init(x: 50, y: 100),
                              size: .init(width: 300, height: 160)))

        Spacer()

        PathSlider(path: path, value: $value, in: 0...1, pathPoint: $dragPoint) {
            Circle()
                .stroke(.blue, lineWidth: 2.0)
                .fill(.blue.gradient)
                .frame(width: 20, height: 20, alignment: .center)
        } track: { path in
            path
                .stroke(Color.primary.opacity(0.2), lineWidth: 2)
        }

        Slider(value: $value, in: 0...1)

        Spacer()
    }
}

#Preview {
    EllipseView()
}
