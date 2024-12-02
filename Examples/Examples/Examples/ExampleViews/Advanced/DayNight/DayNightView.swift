//
//  Copyright © 2024 Austin Emmons
//
    
import SwiftUI
import PathSlider

struct DayNightView: View {

    @State private var skyItemPoint: CGPoint = .zero
    @State private var progress = 0.25

    //    private var trackModel = TrackModel()
    var isSun: Bool { progress < 0.5 }

    var lightAngle: Double {
        let p = progress == 1.0 ? 0.999999 : progress // 0 remainder and 1.0 don't play well
        let halfP = Double(p).truncatingRemainder(dividingBy: 0.5)

        let idxQuarter = Int(p / 0.25)
        let offset = Double(18)

        if idxQuarter.isMultiple(of: 2) {
            return (halfP * 360.0) + offset
        } else {
            return (halfP * 360.0) - offset
        }
    }

    var body: some View {
        ZStack {
            GeometryReader { proxy in
                let rect = proxy.frame(in: .local)

                PathSlider(path: SkyPath.path(rect: rect, addInset: true), value: $progress, pathPoint: $skyItemPoint) {
                    indicator
                } track: { path in
                    Image("Mountain_01")
                        .resizable()

                    SkyLight(
                        isSun: isSun,
                        point: skyItemPoint.normalized(in: rect),
                        angle: .degrees(lightAngle)
                    )

                    path.stroke(Color.gray.opacity(0.3), lineWidth: 1)
                }
            }
            .aspectRatio(4/3, contentMode: .fit)
        }
        .animation(.default, value: isSun)
        .background(background)
    }

    @ViewBuilder
    private var indicator: some View {
        if isSun {
            SunSkyIndicator()
        } else {
            MoonSkyIndicator()
        }
    }

    @ViewBuilder
    private var background: some View {
        if isSun {
            DaySkyBackground()
        } else {
            NightSkyBackground()
        }
    }
}

#Preview {
    DayNightView()
}
