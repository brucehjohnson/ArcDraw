import SwiftUI
import UniformTypeIdentifiers

struct TabArcs: View {
  @ObservedObject var doc: ArcDrawDocument

  init(doc: ArcDrawDocument) {
    self.doc = doc
  }

  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {

        Section(header:
                  Text("Drawing Curves (Arcs)")
          .font(.headline)
          .fontWeight(.medium)
          .frame(maxWidth: .infinity, alignment: .center)

        ) {

          HStack {

            Button("Add New Curve") { doc.addArcDefinition() }
              .help("Add a new arc definition.")
              .padding([.bottom], 2)
          }

          ArcListView(doc: doc)
            .background(Color.red.opacity(0.5))
            .frame(height: 300)

        }// end section

        Divider()

        Section(header:
                  Text("")
          .font(.headline)
          .fontWeight(.medium)
          .frame(maxWidth: .infinity)
        ) {

          VStack(alignment: .leading) {
            Text("Click and drag the arc number to reorder.")
            Text("Click on the arc to modify.")
          }
        } // end section

        Spacer() // Pushes everything above it to take as little space as possible

      } // end vstack

    } // end scrollview
  } // end body

}
