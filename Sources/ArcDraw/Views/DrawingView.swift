import SwiftUI

struct DrawingView: View {
  @ObservedObject var controller: DrawingController

  var body: some View {
    GeometryReader { _ in
      Path { path in
        for line in controller.lines {
          guard let startPoint = line.points.first else { continue }
          path.move(to: startPoint)
          for point in line.points {
            path.addLine(to: point)
          }
        }
      }
      .stroke(Color.black, lineWidth: 2)
      .background(Color.white)
      .gesture(
        DragGesture(minimumDistance: 0.1)
          .onChanged({ (value) in
            controller.addPoint(value.location)
          })
          .onEnded({ (_) in
            controller.startNewLine()
          })
      )
    }
  }
}
