//
//  Copyright © 2024 Austin Emmons
//

import struct Foundation.CGPoint
import CoreGraphics


@available(iOS, introduced: 1, deprecated: 18, message: "Hashable conformance for CGPoint is only available below iOS 18")
extension CGPoint: @retroactive Hashable { }
