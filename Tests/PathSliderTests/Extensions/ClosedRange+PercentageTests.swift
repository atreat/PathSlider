//
//  Copyright © 2024 Austin Emmons
//
    

import Testing

@testable import PathSlider

struct Test {

    @Test func item_for_percentage_int_range_provides_correct_value() async throws {

        let range: ClosedRange<Float> = 0...10.0

        #expect(range.item(for: 0) == 0)

        #expect(range.item(for: 0.1) == 1.0)
        #expect(range.item(for: 0.15) == 1.5)
        #expect(range.item(for: 0.5) == 5.0)

        #expect(range.item(for: 1) == 10.0)
    }

}
