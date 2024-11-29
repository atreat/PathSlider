//  Copyright © 2024 Austin Emmons
//

import SwiftUI

public struct PathSlider<Indicator, Track, V: Strideable>: View where Indicator : View, Track : View, V.Stride : BinaryFloatingPoint {
    private let model: PathTrack

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
    public init(
        path: Path,
        value: Binding<V>?,
        in range: ClosedRange<V>,
        pathPoint: Binding<CGPoint>?,
        indicator: @escaping () -> Indicator,
        track: @escaping (Path) -> Track
    ) {
        self.model = PathTrack(path: path)
        self.range = range
        self._internalValue = State(initialValue: value?.wrappedValue ?? range.lowerBound)
        self._internalPathPoint = State(initialValue: .zero)

        // Create bindings that use internal state if external binding isn't provided
        self.valueBinding = value ?? _internalValue.projectedValue
        self.pathPointBinding = pathPoint ?? _internalPathPoint.projectedValue

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
    ) {
        self.init(
            path: path,
            value: value,
            in: range,
            pathPoint: nil,
            indicator: indicator,
            track: track
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
                .onChanged { value in
                    let loc = value.location
                    if let closest = model.closest(from: loc) {
                        withAnimation(.default) {
                            // Update the position of the indicator smoothly
                            valueBinding.wrappedValue = range.item(for: model.percentage(for: closest))
                            pathPointBinding.wrappedValue = closest
                        }
                    } else {
                        // TODO: when is there not a closest item?
                    }
                }
                .onEnded { value in
                    let loc = value.location
                    if let closest = model.closest(from: loc) {
                        withAnimation(.default) {
                            // Update the position of the indicator smoothly
                            valueBinding.wrappedValue = range.item(for: model.percentage(for: closest))
                            pathPointBinding.wrappedValue = closest
                        }
                    } else {
                        // TODO: when is there not a closest item?
                    }
                }
        )
        .onAppear {
            // TODO: Decide if `value` or `pathPoint` should take precendence for initial position
            let point = pathPointBinding.wrappedValue
            if let closest = model.closest(from: point) {
                self.pathPointBinding.wrappedValue = closest
                valueBinding.wrappedValue = range.item(for:  model.percentage(for: closest))
            }
        }
        .onChange(of: valueBinding.wrappedValue) { newValue in
            // When value changes externally, need to update the pathPoint to match
            if let bfp = newValue as? any BinaryFloatingPoint {
                self.pathPointBinding.wrappedValue = model.point(for: Float(bfp))
            } else {
                // TODO: what if value is not BinaryFloatingPoint?
            }
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

//struct PathSlider_Previews: PreviewProvider {
//
//    @State static var point: CGPoint = .zero
//    static var previews: some View {
//        let path = Path(ellipseIn: CGRect(origin: .zero, size: .init(width: 300, height: 160)))
//        PathSlider(path: path, pathPoint: $point) {
//            // indicator
//            PathPoint()
//                .frame(width: 14, height: 14)
//        } track: { path in
//            path.stroke(Color.black.opacity(0.5), lineWidth: 2)
//        }
//    }
//}
