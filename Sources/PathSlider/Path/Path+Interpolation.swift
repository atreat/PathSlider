//
//  Copyright © 2024 Austin Emmons
//
    
// Modified from https://github.com/agordeev/BezierPathClosestPoint

import SwiftUI

@available(macOS 11, *)
extension Path {

    var count: Int {
        var c = 0
        forEach { _ in c += 1 }
        return c
    }

    var strokeSegmentCount: Int {
        var c = 0
        forEach { element in
            switch element {
            case .line(to: _),
                    .quadCurve(to: _, control: _),
                    .curve(to: _, control1: _, control2: _),
                    .closeSubpath:
                c += 1
            default:
                break
            }
        }
        return c
    }

    func generateLookup(capacity: Int = 100) -> [CGPoint] {
        let count = strokeSegmentCount
        guard count > 0 else { return [] }

        let capacityPerSegment = capacity / count

        var lookupTable = [CGPoint]()
        var previousPoint: CGPoint?

        forEach { element in
            switch element {
            case .move(to: let point):
                    previousPoint = point
            case .line(to: let point):
                guard let prevPoint = previousPoint else { break }

                for i in 0...capacityPerSegment {
                    let t = CGFloat(i) / CGFloat(capacityPerSegment)
                    let point = calculateLinear(t: t, p1: prevPoint, p2: point)
                    lookupTable.append(point)
                }
                previousPoint = point
            case .quadCurve(to: let point, control: let control):
                guard let prevPoint = previousPoint else { break }

                for i in 0...capacityPerSegment {
                    let t = CGFloat(i) / CGFloat(capacityPerSegment)
                    let point = calculateQuad(t: t, p1: prevPoint, p2: control, p3: point)
                    lookupTable.append(point)
                }
                previousPoint = point
            case .curve(to: let point, control1: let control1, control2: let control2):
                guard let prevPoint = previousPoint else { break }

                for i in 0...capacityPerSegment {
                    let t = CGFloat(i) / CGFloat(capacityPerSegment)
                    let point = calculateCube(t: t, p1: prevPoint, p2: control1, p3: control2, p4: point)
                    lookupTable.append(point)
                }
                previousPoint = point
            case .closeSubpath:
                guard let prevPoint = previousPoint else { break }
                guard let firstPoint = lookupTable.first else { break }

                guard prevPoint != firstPoint else {
                    // prevent adding to lookup if subpath is at starting point already
                    break
                }

                for i in 0...capacityPerSegment {
                    let t = CGFloat(i) / CGFloat(capacityPerSegment)
                    let point = calculateLinear(t: t, p1: prevPoint, p2: firstPoint)
                    lookupTable.append(point)
                }
                previousPoint = firstPoint
            }
        }

        return lookupTable
    }

// MARK: - Calculations
    /// Calculates a point at given t value, where t in 0.0...1.0
    private func calculateLinear(t: CGFloat, p1: CGPoint, p2: CGPoint) -> CGPoint {
        let mt = 1 - t
        let x = mt*p1.x + t*p2.x
        let y = mt*p1.y + t*p2.y
        return CGPoint(x: x, y: y)
    }

    /// Calculates a point at given t value, where t in 0.0...1.0
    private func calculateCube(t: CGFloat, p1: CGPoint, p2: CGPoint, p3: CGPoint, p4: CGPoint) -> CGPoint {
        let mt = 1 - t
        let mt2 = mt*mt
        let t2 = t*t

        let a = mt2*mt
        let b = mt2*t*3
        let c = mt*t2*3
        let d = t*t2

        let x = a*p1.x + b*p2.x + c*p3.x + d*p4.x
        let y = a*p1.y + b*p2.y + c*p3.y + d*p4.y
        return CGPoint(x: x, y: y)
    }

    /// Calculates a point at given t value, where t in 0.0...1.0
    private func calculateQuad(t: CGFloat, p1: CGPoint, p2: CGPoint, p3: CGPoint) -> CGPoint {
        let mt = 1 - t
        let mt2 = mt*mt
        let t2 = t*t

        let a = mt2
        let b = mt*t*2
        let c = t2

        let x = a*p1.x + b*p2.x + c*p3.x
        let y = a*p1.y + b*p2.y + c*p3.y
        return CGPoint(x: x, y: y)
    }
}
