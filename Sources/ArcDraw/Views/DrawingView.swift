import SwiftUI

struct DrawingView: View {

  @ObservedObject var doc: ArcDrawDocument
  @Binding var selectedExample: String

  init(doc: ArcDrawDocument, selectedExample: Binding<String>) {
    self.doc = doc
    self._selectedExample = selectedExample
  }

  var body: some View {
    GeometryReader { _ in
      Path { path in
        for line in doc.drawingController.lines {
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
            doc.drawingController.addPoint(value.location)
          })
          .onEnded({ (_) in
            doc.drawingController.startNewLine()
          })
      )
    }
    .onAppear {
      doc.drawingController.updateDrawing(for: selectedExample)
    }
  }
}
