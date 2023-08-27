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

          HStack {
            Text("Number: \(arcDefinition.num)")
              .frame(maxWidth: 80)

            Text("Name: \(arcDefinition.name)")
              .frame(maxWidth: 150)

            Text("Description: \(arcDefinition.description)")
              .frame(maxWidth: 200)

//            Text("Dot Locations: \(arcDefinition.dotLocations)")
//              .frame(maxWidth: 150)

            Text("Start Angle: \(arcDefinition.startAngle)")
              .frame(maxWidth: 100)

            Text("End Angle: \(arcDefinition.endAngle)")
              .frame(maxWidth: 100)

            Text("Clockwise: \(arcDefinition.isClockwise ? "Yes" : "No")")
              .frame(maxWidth: 80)

            Text("Num: \(arcDefinition.num)")
              .frame(maxWidth: 50)

            Button(role: .destructive) {
              doc.deleteArcDefinition(index: i)
              updateArcDefinitionNums()
            } label: {
              Image(systemName: "trash")
            }
            .help("Delete \(arcDefinition.num)")
          }
        }
        .onMove { indices, arcDefinition in
          doc.picdef.arcDefinitions.move(
            fromOffsets: indices,
            toOffset: arcDefinition
          )
          updateArcDefinitionNums()
        }
      } // end list
      .frame(height: geometry.size.height)
    } // end geometry reader
    .frame(maxHeight: .infinity)
  } // end body
}

/*



 // Update  nums after moviing or deleting
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


 HStack {
 TextField("number", value: $arcDefinition.num, formatter: ADFormatters.fmtIntColorOrderNumber)
 .disabled(true)
 .frame(maxWidth: 15)



 // enter blue

 //            TextField("255", value: $arcDefinition.b, formatter: ADFormatters.fmt0to255) { isStarted in
 //              if isStarted {
 //             //   activeDisplayState = .Colors
 //              }
 //            }
 //            .onChange(of: arcDefinition.b) { newValue in
 //              doc.updatearcDefinitionWithColorNumberB(
 //                index: i, newValue: newValue
 //              )
 //            }

 Button(role: .destructive) {
 doc.deleteArcDefinition(index: i)
 updateArcDefinitionNums()
 } label: {
 Image(systemName: "trash")
 }
 .help("Delete " + "\(arcDefinition.num)")
 }
 } // end foreach
 .onMove { indices, arcDefinition in
 doc.picdef.arcDefinitions.move(
 fromOffsets: indices,
 toOffset: arcDefinition
 )
 updateArcDefinitionNums()
 }
 } // end list
 .frame(height: geometry.size.height)

 } // end geometry reader
 .frame(maxHeight: .infinity)

 } // end body
 }
 */
