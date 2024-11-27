//  Copyright © 2024 Austin Emmons
//

import SwiftUI

public struct PathSlider<Indicator, Track, V: Strideable>: View where Indicator : View, Track : View {
    private let model: PathTrack
    @GestureState private var dragAmount: CGPoint = .zero
    
    // Internal state to hold default values when bindings aren't provided
    @State private var internalValue: V
    @State private var internalPathPoint: CGPoint = .zero
    
    // Store bindings as private properties
    private let pathPointBinding: Binding<CGPoint>
    private let valueBinding: Binding<V>
    private let range: ClosedRange<V>

    let indicator: () -> Indicator
    let track: (Path) -> Track

    // Main initializer that handles all cases
    private init(
        path: Path,
        value: Binding<V>?,
        in range: ClosedRange<V>,
        pathPoint: Binding<CGPoint>?,
        indicator: @escaping () -> Indicator,
        track: @escaping (Path) -> Track
    ) {
        self.model = PathTrack(path: path)
        self.range = range
        self._internalValue = State(initialValue: range.lowerBound)
        self._internalPathPoint = State(initialValue: .zero)
        
        // Create bindings that use internal state if external binding isn't provided
        self.valueBinding = Self.makeBinding(external: value, internalState: _internalValue)
        self.pathPointBinding = Self.makeBinding(external: pathPoint, internalState: _internalPathPoint)

        self.indicator = indicator
        self.track = track
    }

    // Public initializers can now be simplified
    public init(
        path: Path,
        value: Binding<V>,
        in range: ClosedRange<V>,
        indicator: @escaping () -> Indicator,
        track: @escaping (Path) -> Track
    ) where V : BinaryFloatingPoint {
        self.init(
            path: path,
            value: value,
            in: range,
            pathPoint: nil,
            indicator: indicator,
            track: track
        )
    }

    // static helper to create binding without capturing self in initializer
    private static func makeBinding<T>(
        external: Binding<T>?,
        internalState: State<T>
    ) -> Binding<T> {
        external ?? Binding(
            get: { internalState.wrappedValue },
            set: { internalState.wrappedValue = $0 }
        )
    }
}

extension PathSlider {
    public var body: some View {
        ZStack {
            track(model.path)

            indicator()
                .position(
                    x: pathPointBinding.wrappedValue.x,
                    y: pathPointBinding.wrappedValue.y
                )

//            debugPathPoints()
        }
        .coordinateSpace(name: "path-slider")
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .named("path-slider"))
                .updating($dragAmount) { value, state, transaction in
                    state = value.location
                }
                .onChanged { value in
                    withAnimation {
                        // Update the position of the indicator smoothly
                        pathPointBinding.wrappedValue = model.closest(from: value.location) ?? value.location
                    }
                }
                .onEnded { value in
                    withAnimation {
                        // Update the position of the indicator smoothly
                        pathPointBinding.wrappedValue = model.closest(from: value.location) ?? value.location
                    }
                }
        )
        .onAppear {
            let point = pathPointBinding.wrappedValue ?? .zero

            self.pathPointBinding.wrappedValue = model.closest(from: point) ?? point
        }
    }
}

extension PathSlider where V == Double {
    public init(
        path: Path,
        pathPoint: Binding<CGPoint>,
        indicator: @escaping () -> Indicator,
        track: @escaping (Path) -> Track
    ) {
        self.init(
            path: path,
            value: nil,
            in: 0...1,
            pathPoint: pathPoint,
            indicator: indicator,
            track: track
        )
    }
}


#if DEBUG
extension PathSlider {
    @ViewBuilder
    private func debugPathPoints() -> some View {
        ForEach(model.points, id: \.self) { point in
            Circle()
                .stroke(Color.red, lineWidth: 1)
                .frame(width: 4, height: 4, alignment: .center)
                .position(x: point.x, y: point.y)
        }
    }
}
#endif

struct PathSlider_Previews: PreviewProvider {

    @State static var point: CGPoint = .zero
    static var previews: some View {
        let path = Path(ellipseIn: CGRect(origin: .zero, size: .init(width: 300, height: 160)))
//        PathSlider(path: path, pathPoint: $point) {
//            // indicator
//            PathPoint()
//                .frame(width: 14, height: 14)
//        } track: { path in
//            path.stroke(Color.black.opacity(0.5), lineWidth: 2)
//        }

    }
}
