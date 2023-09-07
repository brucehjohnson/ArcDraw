import SwiftUI

struct DrawingView: View {

  @ObservedObject var doc: ArcDrawDocument
  @Binding var selectedExample: String
  @State  var showCurveSelectionAlert: Bool = false
  @State private var dragStartTime: Date?

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
            if dragStartTime == nil {
              dragStartTime = Date()
              print("Started dragging at \(dragStartTime!)")

            }
            doc.drawingController.addPoint(value.location)
          })
          .onEnded({ (value) in
            let dragDuration = Date().timeIntervalSince(dragStartTime!)

            print("Drag ended. Duration was \(dragDuration) seconds.")

            dragStartTime = nil // Reset the start time

            if dragDuration < 0.2 {
              let location = value.location
              print("Determined as a tap at x= \(location.x) and y= \(location.y)")

              if doc.picdef.curves.count > 1 && doc.selectedCurveIndex == nil {
                showCurveSelectionAlert = true
              } else {
                let thisIndex = doc.selectedCurveIndex ?? 0
                print("adding dot, selected curve index is \(thisIndex)")
                var selectedCurve = doc.picdef.curves[thisIndex]
                let newDot = DotDefinition(num: selectedCurve.dots.count + 1, x: "\(location.x)", y: "\(location.y)")
                selectedCurve.dots.append(newDot)
              }
            } else {
              doc.drawingController.startNewLine()
            }
          })
      )
      .alert(isPresented: $showCurveSelectionAlert) {
        print("Must select which curve you're modifying")
        return Alert(title: Text("Select a Curve"), message: Text("Please select a curve to work on."), dismissButton: .default(Text("Okay")))
      }

    }
    .onAppear {
      doc.drawingController.updateDrawing(for: selectedExample)
    }
  }
}
