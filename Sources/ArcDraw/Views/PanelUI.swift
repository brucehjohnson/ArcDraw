import SwiftUI
import UniformTypeIdentifiers

struct PanelUI: View {

  @ObservedObject var doc: ArcDrawDocument

  init(doc: ArcDrawDocument) {
    self.doc = doc
  }

  func aspectRatio() -> Double {
    let h = Double(doc.picdef.imageHeight)
    let w = Double(doc.picdef.imageWidth)
    return max(h / w, w / h)
  }

  var body: some View {
    VStack {
      Text("MandArt Inputs")
        .font(.title)
        .padding(.top)

      TabbedView(doc: doc)
      Spacer()
    }

  }
}
