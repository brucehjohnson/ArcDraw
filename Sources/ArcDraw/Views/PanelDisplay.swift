import SwiftUI
import UniformTypeIdentifiers

struct PanelDisplay: View {

  @ObservedObject var doc: ArcDrawDocument
  @StateObject private var drawingController = DrawingController()

  var body: some View {

    VStack {
      Text("Drawing")
      DrawingView(controller: drawingController)
      Spacer()

    }
  } // body

}
