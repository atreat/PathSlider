//
//  Copyright © 2024 Austin Emmons
//

import SwiftUI

@available(macOS 11, *)
extension Shape {

    
    /// Create a PathSlider using the Shape's Path.
    /// - Parameters:
    ///   - value: The selected value with `bounds`
    ///   - bounds: The range of valid values. Defaults to `0...1`
    ///   - pathPoint: The point along the path which the indicator is positioned
    ///   - indicator: View to use as the indicator
    ///   - track: View builder to render the Path and any accessory views
    /// - Returns: A View that contains the PathSlider
    @MainActor
    public func slider<Indicator: View, Track: View, V: Strideable>(
        value: Binding<V>,
        in bounds: ClosedRange<V> = 0...1,
        pathPoint: Binding<CGPoint>,
        indicator: @escaping () -> Indicator,
        @ViewBuilder track: @escaping (Path) -> Track
    ) -> some View where V.Stride: BinaryFloatingPoint {
        GeometryReader { proxy in
            PathSlider(
                path: path(in: proxy.frame(in: .local)),
                value: value,
                in: bounds,
                pathPoint: pathPoint,
                indicator: indicator,
                track: track
            )
        }
    }

    /// Create a PathSlider using the Shape's Path.
    /// - Parameters:
    ///   - value: The selected value with `bounds`
    ///   - bounds: The range of valid values. Defaults to `0...1`
    ///   - indicator: View to use as the indicator
    ///   - track: View builder to render the Path and any accessory views
    /// - Returns: A View that contains the PathSlider
    @MainActor
    public func slider<Indicator: View, Track: View, V: Strideable>(
        value: Binding<V>,
        in bounds: ClosedRange<V> = 0...1,
        indicator: @escaping () -> Indicator,
        @ViewBuilder track: @escaping (Path) -> Track
    ) -> some View where V.Stride: BinaryFloatingPoint {
        GeometryReader { proxy in
            PathSlider(
                path: path(in: proxy.frame(in: .local)),
                value: value,
                in: bounds,
                indicator: indicator,
                track: track
            )
        }
    }

    /// Create a PathSlider using the Shape's Path.
    /// - Parameters:
    ///   - pathPoint: The point along the path which the indicator is positioned
    ///   - indicator: View to use as the indicator
    ///   - track: View builder to render the Path and any accessory views
    /// - Returns: A View that contains the PathSlider
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
