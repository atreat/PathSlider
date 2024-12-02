//
//  Copyright © 2024 Austin Emmons
//
    

import SwiftUI

struct DaySkyBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12.0)
            .fill(Color("DaySky"))
    }
}

struct NightSkyBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 12.0)
            .fill(Color("NightSky"))
    }
}

struct NightSkyBackground_Previews: PreviewProvider {
    static var previews: some View {
        DaySkyBackground()
        NightSkyBackground()
    }
}
