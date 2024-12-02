//
//  Copyright © 2024 Austin Emmons
//

import SwiftUI

struct SunSkyIndicator: View {
    var body: some View {
        Image(systemName: "sun.max.fill")
            .foregroundColor(Color("SunYellow"))
    }
}

struct MoonSkyIndicator: View {
    var body: some View {
        Image(systemName: "moon.fill")
            .foregroundColor(Color("MoonWhite"))
    }
}

struct SkyIndicator_Previews: PreviewProvider {
    static var previews: some View {
        SunSkyIndicator()
        MoonSkyIndicator()
    }
}
