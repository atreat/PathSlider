//
//  Copyright © 2024 Austin Emmons
//
    

import SwiftUI
import PathSlider

struct TriangleView: View {

    @State var dragPoint: CGPoint = .zero
    @State var value: Float = 0.5

    let path = Path { p in
        p.move(to: .init(x: 200, y: 50))
        p.addLine(to: .init(x: 350, y: 250))
        p.addLine(to: .init(x: 50, y: 250))
        p.addLine(to: .init(x: 200, y: 50))
        p.closeSubpath()
    }

    var body: some View {
        VStack(alignment: .center) {
            Text("value: \(String(format: "%.2f", value))")
            // drag point not passed, will not be able to observe point
            PathSlider(path: path, value: $value, in: 0...1) {
                Circle()
                    .stroke(.blue, lineWidth: 2.0)
                    .fill(.blue.gradient)
                    .frame(width: 20, height: 20, alignment: .center)
            } track: { path in
                path
                    .stroke(Color.primary.opacity(0.2), lineWidth: 2)

                path
                    .trimmedPath(from: 0, to: CGFloat(value))
                    .stroke(Color.green.opacity(0.8), lineWidth: 4)
            }

            // value Binding not passed, will not be updated
            PathSlider(path: path, pathPoint: $dragPoint) {
                Circle()
                    .stroke(.blue, lineWidth: 2.0)
                    .fill(.blue.gradient)
                    .frame(width: 20, height: 20, alignment: .center)
            } track: { path in
                path.stroke(Color.primary.opacity(0.2), lineWidth: 2)
            }

            Text("point: (\(String(format: "%.0f", dragPoint.x)), \(String(format: "%.0f", dragPoint.y)))")

            Slider(value: $value, in: 0...1)
        }
    }
}

#Preview {
    TriangleView()
}
