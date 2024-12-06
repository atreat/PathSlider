//
//  Copyright © 2024 Austin Emmons
//

import SwiftUI

@available(macOS 11, *)
struct PathModel {

    var path: Path

    let points: [CGPoint]

    init(path: Path) {
        self.path = path
        points = path.generateLookup(capacity: 100)
    }

    func point(for t: Float) -> CGPoint {
        points[min(points.count - 1, Int(t * Float(points.count)))]
    }

    func percentage(for point: CGPoint) -> Float {
        guard point != points.last else {
            return 1
        }

        if let idx = points.firstIndex(of: point) {
            return Float(idx) / Float(points.count)
        } else {
            return 0
        }
    }

    func closest(from point: CGPoint) -> CGPoint? {
        points.closest(from: point)
    }
}
