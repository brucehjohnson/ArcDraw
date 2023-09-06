import SwiftUI
import UniformTypeIdentifiers

struct TabCurves: View {
  @ObservedObject var doc: ArcDrawDocument
  @Binding var selectedExample: String

  let exampleOptions = ["Cursive", "Hearts", "Moons", "Petals", "Shapes", "Spirals", "YinYang"]

  init(doc: ArcDrawDocument, selectedExample: Binding<String>) {
    self.doc = doc
    self._selectedExample = selectedExample
  }

  var body: some View {
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
          Text("Click in the curve to modify.")
          Text("Double-click the curve for delete option.")
          Text("Click and drag the curve number to reorder.")
            Button("Add New Curve") {
              print("Clicked New Curve")
              print("Selected curve index: \(doc.selectedCurveIndex)")
              if let iSelected = doc.selectedCurveIndex {
                doc.insertCurve(afterIndex: iSelected)
              } else {
              doc.addNewCurve()
              }
            }
              .help("Add a new arc definition.")
              .padding([.bottom], 2)

          Divider()
          CurveListView(doc: doc, selectedExample: $selectedExample)

        }//  section
        Spacer()
      } //  vstack
  }

}
