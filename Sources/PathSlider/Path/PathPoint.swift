//
//  Copyright © 2024 Austin Emmons
//

import SwiftUI

public struct PathPoint: View {
    public var body: some View {
        Circle()
            .stroke(Color.black)
            .background(Circle().fill(Color.gray.gradient))
            .padding(2)

    }
}
