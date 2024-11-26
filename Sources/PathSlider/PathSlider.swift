//  Copyright © 2024 Austin Emmons
//

import SwiftUI

fileprivate func calculateProgress(point: CGPoint?, points: [CGPoint]) -> Float {
    if let point, let idx = points.firstIndex(of: point) {
        return Float(idx) / Float(points.count)
    } else {
        return 0
    }
}

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
        ZStack(alignment: .topLeading) {
            track

            indicator()
                .frame(alignment: .center)
                .offset(x: dragPoint.x, y: dragPoint.y)


//            debugPathPoints()

        }.gesture(
            DragGesture(minimumDistance: 0).onChanged { state in
                withAnimation {
                    dragPoint = track.closest(from: state.location)!
                }
            }
        ).onAppear {
            self.dragPoint = track.closest(from: $dragPoint.wrappedValue) ?? $dragPoint.wrappedValue
        }

    }

    #if DEBUG
    @ViewBuilder
    private func debugPathPoints() -> some View {
        ForEach(track.points) { point in
            Circle()
                .stroke(Color.red, lineWidth: 1)
                .frame(width: 4, height: 4, alignment: .center)
                .offset(.init(width: point.x - 2, height: point.y - 2))
        }
    }
    #endif
}

#if DEBUG
extension CGPoint: @retroactive Identifiable {
    public var id: String { "\(self)" }
}
#endif


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
