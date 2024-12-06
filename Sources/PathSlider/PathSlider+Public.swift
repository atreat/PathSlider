//
//  Copyright © 2024 Austin Emmons
//
    

import SwiftUI

@available(macOS 11, *)
extension PathSlider {

    /// Creates a slider to select a value from a given range. Also provides binding to current point at which the indicator is placed.
    /// - Parameters:
    ///   - path: The Path which this PathSlider will use to create slider track
    ///   - value: The selected value with `bounds`
    ///   - bounds: The range of valid values. Defaults to `0...1`
    ///   - indicator: View to use as the indicator
    ///   - track: View builder to render the Path and any accessory views
    public init(
        path: Path,
        value: Binding<V>,
        in bounds: ClosedRange<V> = 0...1,
        indicator: @escaping () -> Indicator,
        @ViewBuilder track: @escaping (Path) -> Track
    ) {
        self.init(
            path: path,
            value: value,
            range: bounds,
            pathPoint: nil,
            indicator: indicator,
            track: track
        )
    }

    /// Creates a slider without Binding to value. Only provides Binding to current point at which the indicator is placed.
    /// - Parameters:
    ///   - path: The Path which this PathSlider will use to create slider track
    ///   - pathPoint: The point along the path which the indicator is positioned
    ///   - indicator: View to use as the indicator
    ///   - track: View builder to render the Path and any accessory views
    public init(
        path: Path,
        pathPoint: Binding<CGPoint>,
        indicator: @escaping () -> Indicator,
        @ViewBuilder track: @escaping (Path) -> Track
    ) where V == Double {
        self.init(
            path: path,
            value: nil,
            range: nil,
            pathPoint: pathPoint,
            indicator: indicator,
            track: track
        )
    }

    /// Creates a slider to select a value from a given range. Also provides binding to current point at which the indicator is placed.
    /// - Parameters:
    ///   - path: The Path which this PathSlider will use to create slider track
    ///   - value: The selected value with `bounds`
    ///   - bounds: The range of valid values. Defaults to `0...1`
    ///   - pathPoint: The point along the path which the indicator is positioned
    ///   - indicator: View to use as the indicator
    ///   - track: View builder to render the Path and any accessory views
    public init(
        path: Path,
        value: Binding<V>,
        in bounds: ClosedRange<V> = 0...1,
        pathPoint: Binding<CGPoint>,
        indicator: @escaping () -> Indicator,
        @ViewBuilder track: @escaping (Path) -> Track
    ) {
        self.init(
            path: path,
            value: value,
            range: bounds,
            pathPoint: pathPoint,
            indicator: indicator,
            track: track
        )
    }
}
