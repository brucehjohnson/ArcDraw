import SwiftUI
import UniformTypeIdentifiers

struct PanelDisplay: View {
  @Binding var selectedExample: String

  // Access the shared document instance
  var doc: ArcDrawDocument {
    OneDocManager.shared.document
  }

  var body: some View {
    VStack {
      HStack {
        Text("Drawing")

        if selectedExample == "" {

          Text(doc.selectedCurveIndex == nil ? "Please select curve first" : "Curve \(doc.selectedCurveIndex! + 1)")
        } else {

      Text("- Example \(selectedExample)")

        }
      }

      DrawingView(selectedExample: $selectedExample)
      Spacer()
    }
  }
}
