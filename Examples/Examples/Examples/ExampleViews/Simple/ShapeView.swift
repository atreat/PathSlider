//
//  Copyright © 2024 Austin Emmons
//
    

import SwiftUI
import PathSlider

struct ShapeView: View {
    @State var dragPoint: CGPoint = .zero
    @State var value: Float = 0.5

    var body: some View {
        VStack {
            Circle()
                .slider(value: $value, in: 0...1, pathPoint: $dragPoint) {
                    Circle()
                        .stroke(.blue, lineWidth: 2.0)
                        .fill(.blue.gradient)
                        .frame(width: 20, height: 20, alignment: .center)
                } track: { path in
                    path
                        .stroke(Color.black.opacity(0.6), lineWidth: 2)
                }
                .frame(maxWidth: 300, maxHeight: 280)
                .padding()
            
            
            RoundedRectangle(cornerRadius: 15)
                .trim(from: 0, to: 0.5)
                .slider(value: $value, in: 0...1) {
                    Circle()
                        .stroke(.blue, lineWidth: 2.0)
                        .fill(.blue.gradient)
                        .frame(width: 20, height: 20, alignment: .center)
                } track: { path in
                    path
                        .stroke(Color.black.opacity(0.6), lineWidth: 2)
                }
                .frame(maxWidth: 300, maxHeight: 280)
                .padding()
        }
    }
}

#Preview {
    ShapeView()
}
