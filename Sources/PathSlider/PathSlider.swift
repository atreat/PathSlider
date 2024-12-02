//  Copyright © 2024 Austin Emmons
//

import SwiftUI

public struct PathSlider<Indicator, Track, V: Strideable>: View where Indicator : View, Track : View, V.Stride : BinaryFloatingPoint {
    private let model: PathTrack

    // Internal state to hold default values when bindings aren't provided
    @State private var internalPathPoint: CGPoint = .zero
    
    // Bindings from public interface
    private let pathPointBinding: Binding<CGPoint>?
    private let valueBinding: Binding<V>?
    private let range: ClosedRange<V>?

    // View providers
    let indicator: () -> Indicator
    let track: (Path) -> Track

    // Main initializer that handles all cases
    init(
        path: Path,
        value: Binding<V>?,
        range: ClosedRange<V>?,
        pathPoint: Binding<CGPoint>?,
        indicator: @escaping () -> Indicator,
        @ViewBuilder track: @escaping (Path) -> Track
    ) {
        self.model = PathTrack(path: path)

        // Create bindings that use internal state if external binding isn't provided
        self.pathPointBinding = pathPoint
        self.valueBinding = value
        self.range = range

        // View providers
        self.indicator = indicator
        self.track = track
    }
}

extension PathSlider {
    public var body: some View {
        ZStack {
            track(model.path)

            indicator()
                .position(
                    x: internalPathPoint.x,
                    y: internalPathPoint.y
                )

//            debugPathPoints()
        }
        .coordinateSpace(name: "path-slider")
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .named("path-slider"))
                .onChanged { value in
                    update(with: value.location)
                }
                .onEnded { value in
                    update(with: value.location)
                }
        )
        .onAppear {
            // `value` binding initial value will take precendence over pathPoint
            if let value = valueBinding?.wrappedValue {
                update(with: value)
            } else {
                update(with: pathPointBinding?.wrappedValue ?? .zero)
            }
        }
        .onChange(of: valueBinding?.wrappedValue) { newValue in
            // When value changes externally, need to update the pathPoint to match
            if let val = newValue {
                update(with: val)
            }
        }
        .onChange(of: pathPointBinding?.wrappedValue) { newValue in
            if let val = newValue {
                update(with: val)
            }
        }
    }

    private func update(with point: CGPoint) {
        if let closest = model.closest(from: point) {
            withAnimation(.default) {
                internalPathPoint = closest
                pathPointBinding?.wrappedValue = closest
                valueBinding?.wrappedValue = range?.item(for: model.percentage(for: closest)) ?? 0 as! V
            }
        } else {
            // TODO: what if no closest point?
        }
    }

    private func update(with newValue: V) {
        if let bfp = newValue as? any BinaryFloatingPoint {
            withAnimation(.default) {
                internalPathPoint = model.point(for: Float(bfp))
                pathPointBinding?.wrappedValue = internalPathPoint
                valueBinding?.wrappedValue = bfp as! V
            }
        } else {
            // TODO: what if value is not BinaryFloatingPoint?
        }
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
        PathSlider(path: path, pathPoint: $point) {
            // indicator
            PathPoint()
                .frame(width: 14, height: 14)
        } track: { path in
            path.stroke(Color.black.opacity(0.5), lineWidth: 2)
        }
    }
}
