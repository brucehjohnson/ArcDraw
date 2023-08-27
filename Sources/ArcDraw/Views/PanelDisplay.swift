import SwiftUI
import UniformTypeIdentifiers

struct PanelDisplay: View {

  @ObservedObject var doc: ArcDrawDocument
  @StateObject private var drawingController: DrawingController

  init(doc: ArcDrawDocument) {
    self.doc = doc
    self._drawingController = StateObject(wrappedValue: DrawingController(picdef: doc.picdef))
  }

  var body: some View {

    VStack {
      Text("Drawing")
      DrawingView(controller: drawingController)
      Spacer()

    }

  }

}
