import SwiftUI

struct DrawingView: View {
  @ObservedObject var doc: ArcDrawDocument
  @Binding var selectedExample: String
  @State  var showCurveSelectionAlert: Bool = false

  @State var dragStartTime: Date?
  @State var lastLocation: CGPoint = .zero
  @State private var rightMouseDownLocation: CGPoint = .zero

  var body: some View {
    GeometryReader { geometry in
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
      .contextMenu {
        Button("Add Dot") {
          print("Add Dot at: \(rightMouseDownLocation.x), \(rightMouseDownLocation.y)")
          handleRightClick(at: rightMouseDownLocation, geometry: geometry)
        }
      }
      .gesture(
        DragGesture(minimumDistance: 0.1)
          .onChanged({ (value) in
            doc.drawingController.addPoint(value.location)
            lastLocation = value.location
          })
          .onEnded({ (_) in
            doc.drawingController.startNewLine()
          })
      )
      .alert(isPresented: $showCurveSelectionAlert) {
        Alert(title: Text("Select a Curve"), message: Text("Please select a curve to work on."), dismissButton: .default(Text("Okay")))
      }
    } // geo reader
    .onAppear(perform: {
      NSEvent.addLocalMonitorForEvents(matching: [.rightMouseDown]) {
        self.rightMouseDownLocation = $0.locationInWindow
        return $0
      }
    })
  }

  func handleRightClick(at location: CGPoint, geometry: GeometryProxy) {

    print("Clicked Drawing to Add New Dot Button for document at \(doc)")
    print("Add to curve num \(doc.selectedCurveIndex! + 1)")

    print("location x, y: \(location.x), \(location.y)")

    let frame = geometry.frame(in: .local)
    let localX = lastLocation.x - frame.minX
    let localY = lastLocation.y - frame.minY

    print("local x, y: \(localX), \(localY)")

    let xString = String(describing: Double(localX))
    let yString = String(describing: Double(localY))

    print("double clicked to add dot at \(xString), \(yString)")

    print("Clicked Drawing to Add New Dot Button for document at \(doc)")
    print("Add to curve num \(doc.selectedCurveIndex! + 1)")
    doc.handleAddNewDotRequest(for: doc.selectedCurveIndex!,
                               xString: xString, yString: yString)

  }
}
