//
//  Copyright © 2024 Austin Emmons
//
    

extension ClosedRange where Bound: Strideable, Bound.Stride : BinaryFloatingPoint {

    func item(for percentage: Float) -> Bound {
        return lowerBound.advanced(by: lowerBound.distance(to: upperBound) * Bound.Stride(percentage))
    }

}
