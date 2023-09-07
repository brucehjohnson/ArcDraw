import SwiftUI
import UniformTypeIdentifiers

struct CurveView: View {

  @ObservedObject var doc: ArcDrawDocument
  @Binding var selectedExample: String
  @Binding var curve: CurveDefinition
  @Binding var curveIndex: Int

  let cardBackground = Color.white
  let cardCornerRadius: CGFloat = 10.0
  let cardElevation: CGFloat = 5.0

  init(doc: ArcDrawDocument,
       selectedExample: Binding<String>,
       curve: Binding<CurveDefinition>,
       curveIndex: Binding<Int>
  ) {
    self.doc = doc
    self._selectedExample = selectedExample
    self._curve = curve
    self._curveIndex = curveIndex
  }

  var body: some View {

    VStack(alignment: .leading, spacing: 2) {

      // FIrst row num and name
      HStack {
        Text("#\(curve.num)")

        TextField("name", text: $curve.name)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .frame(maxWidth: 200)

        Button(action: {
          doc.selectedCurveIndex = curveIndex
          print("Clicked delete curve")
          print("  doc name is \(doc.docName)")
          print("  curve num is \(curve.num)")
          print("  selected curve Index is \(doc.selectedCurveIndex)")
          doc.deleteCurve()
        }) {
          Image(systemName: "trash")
            .foregroundColor(.red)
        }
      }

      // second row description of this curve
      TextEditor(text: $curve.description)
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

          TextField("0", value: $curve.startAngle, formatter: ADFormatters.fmtRotationTheta)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .multilineTextAlignment(.trailing)
            .frame(maxWidth: 60)
            .help("Enter the start angle in degrees.")
        }
        VStack(alignment: .center) {
          Text("End angle (º)")

          TextField("0", value: $curve.endAngle, formatter: ADFormatters.fmtRotationTheta)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .multilineTextAlignment(.trailing)
            .frame(maxWidth: 60)
            .help("Enter the ending angle in degrees.")
        }
        VStack(alignment: .center) {
          Text("Clockwise?")
          Toggle(isOn: $curve.isClockwise) {
          }
          .help("Check for clockwise.")

        }
        .padding()

      } // hstack row 3
      .padding(1)

      DotListView(doc: doc, selectedExample: $selectedExample, dots: $curve.dots, curveIndex: $curveIndex)

    } // vstack (card)
    .padding()  // Don't touch rectangle
    .background(cardBackground)  // Card-like background
    .cornerRadius(cardCornerRadius)  // Rounded corners for the card
    .shadow(radius: cardElevation)  // Elevation shadow for the card
    .onTapGesture {
      doc.selectedCurveIndex = curveIndex
    }

  } // body

}
