import SwiftUI
import UniformTypeIdentifiers

struct ArcListView: View {
  @ObservedObject var doc: ArcDrawDocument

  // Update nums after moving or deleting
  internal func updateArcDefinitionNums() {
    for (index, _) in self.$doc.picdef.arcDefinitions.enumerated() {
      self.doc.picdef.arcDefinitions[index].num = index + 1
    }
  }

    var body: some View {
      // Wrap the list in a geometry reader so it will
      // shrink when items are deleted
      GeometryReader { geometry in
        List {

          ForEach($doc.picdef.arcDefinitions, id: \.num) { $arcDefinition in

            let i = arcDefinition.num - 1

            Rectangle()
              .frame(height: 200)  // Adjust this height to your liking.
              .foregroundColor(Color.secondary.opacity(0.2))
              .cornerRadius(10)
              .overlay(

                VStack(alignment: .leading, spacing: 2) {

                  // FIrst row num and name
                  HStack {
                    Text("#\(arcDefinition.num)")
                    TextField("name", text: $arcDefinition.name)
                      .textFieldStyle(RoundedBorderTextFieldStyle())
                      .frame(maxWidth: 120)
                  }

                  // second row description of this curve
                  TextEditor(text: $arcDefinition.description)
                    .frame(height: 24)
                    .overlay(
                      RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.all)

                  // third row start / end angles

                    HStack {
                      VStack(alignment: .center) {
                        Text("Start angle (º)")

                        TextField("0", value: $arcDefinition.startAngle, formatter: ADFormatters.fmtRotationTheta)
                          .textFieldStyle(RoundedBorderTextFieldStyle())
                          .multilineTextAlignment(.trailing)
                          .frame(maxWidth: 60)
                          .help("Enter the start angle in degrees.")
                      }
                      VStack(alignment: .center) {
                        Text("End angle (º)")

                        TextField("0", value: $arcDefinition.endAngle, formatter: ADFormatters.fmtRotationTheta)
                          .textFieldStyle(RoundedBorderTextFieldStyle())
                          .multilineTextAlignment(.trailing)
                          .frame(maxWidth: 60)
                          .help("Enter the ending angle in degrees.")
                      }
                      VStack(alignment: .center) {
                        Text("Clockwise?")
                        Toggle(isOn: $arcDefinition.isClockwise) {
                        }
                        .help("Check for clockwise.")

                      }
                      .padding()

                    } // hstack row 3
                    .padding(1)

                  } // vstack (card)
                  .padding(2)  // don't touch edges of Rectangle.

              ) // overlay
              .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
              .onTapGesture {
                // Handle card tap if needed
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
            doc.picdef.arcDefinitions.move(
              fromOffsets: indices,
              toOffset: arcDefinition
            )
            updateArcDefinitionNums()
          }
        } // list
        .frame(height: geometry.size.height)
      }  // geo
      .frame(maxHeight: .infinity)
    } // body
}
