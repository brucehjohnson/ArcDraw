import SwiftUI
import UniformTypeIdentifiers

struct PanelUI: View {

  @ObservedObject var doc: ArcDrawDocument
  @Binding var selectedExample: String

  init(doc: ArcDrawDocument, selectedExample: Binding<String>) {
    self.doc = doc
    self._selectedExample = selectedExample
  }

  func aspectRatio() -> Double {
    let h = Double(doc.picdef.imageHeight)
    let w = Double(doc.picdef.imageWidth)
    return max(h / w, w / h)
  }

  var body: some View {
    VStack {
      Text("ArcDraw Inputs")
        .font(.title)
        .padding(.top)

      TabbedView(doc: doc, selectedExample: $selectedExample)
      Spacer()
    }

  }
}
