//
//  Copyright © 2024 Austin Emmons
//
    
import struct Foundation.CGPoint
import math_h

extension CGPoint {
    public static func distance(from fromPoint: CGPoint, to toPoint: CGPoint) -> Float {
        let xDist = Float(fromPoint.x - toPoint.x)
        let yDist = Float(fromPoint.y - toPoint.y)
        return hypotf(xDist, yDist)
    }

    public func distance(to point: CGPoint) -> Float {
        return Self.distance(from: self, to: point)
    }
}

extension Collection where Element == CGPoint {
    public func closest(from point: CGPoint) -> CGPoint? {
        self.min { pointA, pointB in
            CGPoint.distance(from: point, to: pointA) < CGPoint.distance(from: point, to: pointB)
        }
    }
}
