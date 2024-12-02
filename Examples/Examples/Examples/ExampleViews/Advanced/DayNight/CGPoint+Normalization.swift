//
//  Copyright © 2024 Austin Emmons
//

// MARK: - SwiftUI
import struct SwiftUI.UnitPoint
import struct Foundation.CGPoint
import struct Foundation.CGRect

extension CGPoint {
    func normalized(in rect: CGRect) -> UnitPoint {
        .init(x: x / rect.width, y: y / rect.height)
    }
}
