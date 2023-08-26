import SwiftUI
import CoreGraphics

class DrawingController: ObservableObject {
  @Published var lines: [Line] = []

  func addPoint(_ point: CGPoint) {
    if var lastLine = lines.popLast() {
      lastLine.points.append(point)
      lines.append(lastLine)
    } else {
      lines.append(Line(points: [point]))
    }
  }

  func startNewLine() {
    lines.append(Line(points: []))
  }
}
