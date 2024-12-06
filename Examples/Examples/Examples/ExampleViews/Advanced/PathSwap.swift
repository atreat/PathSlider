//
//  Copyright © 2024 Austin Emmons
//
    

import SwiftUI
import PathSlider

struct PathSwap: View {

    let ellipse = Path(ellipseIn: CGRect(origin: .init(x: 50, y: 100), size: .init(width: 300, height: 160)))

    var ellipseBottom: Path { ellipse.trimmedPath(from: 0, to: 0.5) }

    var ellipseTop: Path { ellipse.trimmedPath(from: 0.5, to: 1) }

    @State private var value = 0.5
    @State private var showTop = true
    @State private var pendingTask: Task<Void, Never>?

    var path: Path { showTop ? ellipseTop : ellipseBottom }

    func debounceToggle() {
        // Cancel any existing pending task
        pendingTask?.cancel()

        // Create new debounced task
        pendingTask = Task {
            try? await Task.sleep(for: .milliseconds(100))
            
            if !Task.isCancelled {
                await MainActor.run {
                    showTop.toggle()
                }
            }
        }
    }

    var body: some View {
        Toggle("Flip", isOn: $showTop)
            .frame(maxWidth: 200)

        PathSlider(path: path, value: $value) {
            Capsule().fill(Color.green.gradient)
                .frame(width: 14, height: 14, alignment: .center)
        } track: { path in
            path.stroke(Color.gray.opacity(0.6), lineWidth: 2)
        }.onChange(of: value) { _, newValue in
            if newValue == 0 || newValue == 1 {
                debounceToggle()
            }
        }
    }
}

#Preview {
    PathSwap()
}
