//
//  Copyright © 2024 Austin Emmons
//

import SwiftUI

@available(macOS 11, *)
struct PathModel {

    let path: Path

    let points: [CGPoint]

    init(path: Path, lookupCapacity: Int = 100) {
        self.path = path
        points = path.generateLookup(capacity: lookupCapacity)
    }
}
