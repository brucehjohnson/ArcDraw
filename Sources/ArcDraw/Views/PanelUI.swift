import SwiftUI
import UniformTypeIdentifiers

struct PanelUI: View {

  @Binding var selectedExample: String

  // Access the shared document instance
  var doc: ArcDrawDocument {
    OneDocManager.shared.document
  }

  init( selectedExample: Binding<String>) {
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

      TabbedView(selectedExample: $selectedExample)
      Spacer()
    }

  }
}
