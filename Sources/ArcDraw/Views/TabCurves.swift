import SwiftUI
import UniformTypeIdentifiers

struct TabCurves: View {
  @ObservedObject var doc: ArcDrawDocument
  @State private var selectedExample: String = "Shapes"

  let exampleOptions = ["Cursive", "Hearts", "Moons", "Petals", "Shapes", "Spirals", "YinYang"]

  init(doc: ArcDrawDocument) {
    self.doc = doc
  }

  var body: some View {
   // ScrollView {
      VStack {
        if doc.picdef.pictureName != "Name" && !doc.picdef.pictureName.isEmpty {
          Text("\(doc.picdef.pictureName)")
        }
        Divider()

        Section(header:
                  Text("Drawing Curves (Arcs)")
          .font(.headline)
          .fontWeight(.medium)
          .frame(maxWidth: .infinity, alignment: .center)

        ) {

            Text("Click and drag the curve number to reorder.")
            Text("Click on the curve to modify.")

            Button("Add New Curve") {
              print("Clicked New Curve")
              print("Selected curve index: \(doc.selectedCurveIndex)")
              if let selectedArcIndex = doc.selectedCurveIndex {
                doc.addCurveAfter(atArcIndex: selectedArcIndex)
              } else {
              doc.addArcDefinition()
              }
            }
              .help("Add a new arc definition.")
              .padding([.bottom], 2)

          Divider()

          CurveListView(doc: doc)

        }// end section

        Spacer()
      } //  vstack
   // } //  scrollview
  } //  body

}
