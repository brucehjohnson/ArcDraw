import SwiftUI
import UniformTypeIdentifiers

struct PanelDisplay: View {
  @ObservedObject var doc: ArcDrawDocument
  @Binding var selectedExample: String

  var body: some View {
    VStack {
      Text("Drawing")
      DrawingView(doc: doc, selectedExample: $selectedExample)
      Spacer()
    }
  }
}
