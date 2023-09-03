import SwiftUI
import UniformTypeIdentifiers

struct CurveListView: View {
  @ObservedObject var doc: ArcDrawDocument

  // Update nums after moving or deleting
  internal func updateArcDefinitionNums() {
    for (index, _) in self.$doc.picdef.curves.enumerated() {
      self.doc.picdef.curves[index].num = index + 1
    }
  }

    var body: some View {

        VStack {

          // Add a button to delete the selected curve
          Button("Delete Selected Curve") {
            if let selectedArcIndex = doc.selectedCurveIndex {
              doc.deleteArcDefinition(index: selectedArcIndex)
              updateArcDefinitionNums()
            }
          }
          .disabled(doc.selectedCurveIndex == nil) // Disable the button when no curve is selected

          // Wrap the list in a geometry reader so it will
          // shrink when items are deleted
          GeometryReader { geometry in
            List {

              ForEach($doc.picdef.curves, id: \.num) { $arcDefinition in

                let i = arcDefinition.num - 1

                Rectangle()
                  .frame(height: 400)  // Adjust this height to your liking.
                  .foregroundColor(Color.secondary.opacity(0.2))
                  .cornerRadius(10)
                  .overlay(
                    CurveView(doc: doc, curve: arcDefinition)
                  ) // overlay
                  .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                  .onTapGesture {
                    // Set the selected curve index when tapped
                    doc.selectedCurveIndex = i
                  }
                  .contextMenu {
                    Button(role: .destructive) {
                      doc.deleteArcDefinition(index: i)
                      updateArcDefinitionNums()
                    } label: {
                      Label("Delete", systemImage: "trash")
                    }
                  }
              }
              .onMove { indices, arcDefinition in
                doc.picdef.curves.move(
                  fromOffsets: indices,
                  toOffset: arcDefinition
                )
                updateArcDefinitionNums()
              }

            } // list
            .frame(height: geometry.size.height)
          }  // geo
          .frame(maxHeight: .infinity)
        }
        .border(Color.black)

        Spacer()

    } // body
}
