//
//  Copyright © 2024 Austin Emmons
//
    
import SwiftUI

class SkyPath {
    static func path(rect: CGRect, addInset: Bool) -> Path {
        var p = Path()

        let inset = rect.width * 0.2
        let top = rect.minY + 12
        let bottom = rect.midY * 1.3
        let controlX = rect.width * 0.7

        p.move(to: .init(x: rect.minX + inset, y: bottom))
        p.addCurve(
            to: .init(x: rect.midX, y: top),
            control1: .init(x: rect.midX - controlX, y: top),
            control2: .init(x: rect.midX, y: top)
        )

        p.addCurve(
            to: .init(x: rect.maxX - inset, y: bottom),
            control1: .init(x: rect.midX, y: top),
            control2: .init(x: rect.midX + controlX, y: top)
        )

        if addInset {
            p.addPath( path(rect: rect.insetBy(dx: 10, dy: 10), addInset: false) )
        }
        return p
    }
}
