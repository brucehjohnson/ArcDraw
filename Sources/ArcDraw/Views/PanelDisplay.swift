import SwiftUI
import UniformTypeIdentifiers

struct PanelDisplay: View {
  @ObservedObject var doc: ArcDrawDocument
  @Binding var selectedExample: String

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

      DrawingView(doc: doc, selectedExample: $selectedExample)
      Spacer()
    }
  }
}
