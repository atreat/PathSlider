//
//  Copyright © 2024 Austin Emmons
//

import SwiftUI

struct SkyLight: View {
    let dayColor = Color("SunYellow")
    let nightColor = Color("MoonWhite")



    let isSun: Bool
    let point: UnitPoint
    let angle: Angle
    let arcAngle: Angle

    var color: Color { isSun ? dayColor : nightColor  }
    var gradient: Gradient {
        Gradient(stops: [
            .init(color: .clear, location: 0.0),
            .init(color: color, location: 0.5),
            .init(color: .clear, location: 1.0)
        ])
    }

    init(isSun: Bool, point: UnitPoint, angle: Angle, arcAngle: Angle = .degrees(120)) {
        self.isSun = isSun
        self.point = point
        self.angle = angle
        self.arcAngle = arcAngle
    }

    var halfArc: Angle { arcAngle / 2 }
    var startAngle: Angle { angle - halfArc }
    var endAngle: Angle { angle + halfArc }

    var body: some View {
        Rectangle()
            .fill(
                AngularGradient(gradient: gradient, center: point, startAngle: startAngle, endAngle: endAngle)
            ).opacity(0.5)
    }
}

struct SkyLight_Previews: PreviewProvider {
    static var previews: some View {
        SkyLight(isSun: true, point: .zero, angle: .degrees(90))
        SkyLight(isSun: false, point: .zero, angle: .degrees(90))
    }
}
