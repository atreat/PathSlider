//  Copyright © 2024 Austin Emmons
//

import SwiftUI

public struct PathSlider<Indicator>: View where Indicator : View {
    let track: PathTrack

    @Binding var dragPoint: CGPoint

    let indicator: () -> Indicator

    public init(track: PathTrack, dragPoint: Binding<CGPoint>, indicator: @escaping () -> Indicator) {
        self.track = track
        self._dragPoint = dragPoint
        self.indicator = indicator
    }

    public var body: some View {
        ZStack {
            track

            indicator()
                .position(x: dragPoint.x, y: dragPoint.y)

//            debugPathPoints()
        }
        .coordinateSpace(name: "path-slider")
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .named("path-slider")).onChanged { state in
                withAnimation {
                    dragPoint = track.closest(from: state.location) ?? .zero
                }
            }
        )
        .onAppear {
            self.dragPoint = track.closest(from: $dragPoint.wrappedValue) ?? $dragPoint.wrappedValue
        }
    }

    #if DEBUG
    @ViewBuilder
    private func debugPathPoints() -> some View {
        ForEach(track.points, id: \.self) { point in
            Circle()
                .stroke(Color.red, lineWidth: 1)
                .frame(width: 4, height: 4, alignment: .center)
                .position(x: point.x, y: point.y)
        }
    }
    #endif
}

struct PathSlider_Previews: PreviewProvider {

    @State static var point: CGPoint = .zero
    static var previews: some View {
        let path = Path(ellipseIn: CGRect(origin: .zero, size: .init(width: 300, height: 160)))

        PathSlider(track: PathTrack(path: path), dragPoint: $point) {
            PathPoint()
                .frame(width: 14, height: 14)
        }
    }
}
