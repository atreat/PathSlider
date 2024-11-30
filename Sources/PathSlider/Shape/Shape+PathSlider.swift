//
//  Copyright © 2024 Austin Emmons
//
    
import SwiftUI

extension Shape {

    @MainActor
    public func slider<Indicator: View, Track: View, V: Strideable>(
        value: Binding<V>,
        range: ClosedRange<V>,
        pathPoint: Binding<CGPoint>,
        indicator: @escaping () -> Indicator,
        @ViewBuilder track: @escaping (Path) -> Track
    ) -> some View where V.Stride: BinaryFloatingPoint {
        GeometryReader { proxy in
            PathSlider(
                path: path(in: proxy.frame(in: .local)),
                value: value,
                in: range,
                pathPoint: pathPoint,
                indicator: indicator,
                track: track
            )
        }
    }

    @MainActor
    public func slider<Indicator: View, Track: View, V: Strideable>(
        value: Binding<V>,
        range: ClosedRange<V>,
        indicator: @escaping () -> Indicator,
        @ViewBuilder track: @escaping (Path) -> Track
    ) -> some View where V.Stride: BinaryFloatingPoint {
        GeometryReader { proxy in
            PathSlider(
                path: path(in: proxy.frame(in: .local)),
                value: value,
                in: range,
                indicator: indicator,
                track: track
            )
        }
    }

    @MainActor
    public func slider<Indicator: View, Track: View>(
        pathPoint: Binding<CGPoint>,
        indicator: @escaping () -> Indicator,
        @ViewBuilder track: @escaping (Path) -> Track
    ) -> some View {
        GeometryReader { proxy in
            PathSlider(
                path: path(in: proxy.frame(in: .local)),
                pathPoint: pathPoint,
                indicator: indicator,
                track: track
            )
        }
    }
}
