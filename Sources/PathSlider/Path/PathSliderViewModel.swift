import SwiftUI

@available(macOS 11, *)
final class PathSliderViewModel: ObservableObject {
    @Published var internalPathPoint: CGPoint = .zero

    @Published var model: PathModel

    var path: Path { model.path }
    var points: [CGPoint] { model.points }

    init() {
        self.model = PathModel(path: Path())
    }

    func update(path: Path) {
        self.model = PathModel(path: path)
    }
}

extension PathSliderViewModel {
    func point(for t: Float) -> CGPoint {
        if points.isEmpty { return .zero }

        return points[min(points.count - 1, Int(t * Float(points.count)))]
    }

    func percentage(for point: CGPoint) -> Float {
        guard point != points.last else {
            return 1
        }

        if let idx = points.firstIndex(of: point) {
            return Float(idx) / Float(points.count)
        } else {
            return 0
        }
    }

    func closest(from point: CGPoint) -> CGPoint? {
        points.closest(from: point)
    }
}
