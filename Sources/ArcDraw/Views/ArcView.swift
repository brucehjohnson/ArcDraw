import SwiftUI
import UniformTypeIdentifiers

struct ArcView: View {

  @ObservedObject var doc: ArcDrawDocument
  @StateObject private var drawingController: DrawingController
  @State var curve: CurveDefinition
  @State var dots: [DotDefinition]

  let cardBackground = Color.white
  let cardCornerRadius: CGFloat = 10.0
  let cardElevation: CGFloat = 5.0

  init(doc: ArcDrawDocument, curve: CurveDefinition) {
    self.doc = doc
    self.curve = curve
    self._drawingController = StateObject(wrappedValue: DrawingController(picdef: doc.picdef))
    self._dots = State(initialValue: curve.dots)
  }

  var body: some View {

    VStack(alignment: .leading, spacing: 2) {

      // FIrst row num and name
      HStack {
        Text("#\(curve.num)")
        TextField("name", text: $curve.name)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .frame(maxWidth: 120)
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

      DotsView(doc: doc, dots: $curve.dots)

    } // vstack (card)
    .padding()  // Don't touch rectangle
    .background(cardBackground)  // Card-like background
    .cornerRadius(cardCornerRadius)  // Rounded corners for the card
    .shadow(radius: cardElevation)  // Elevation shadow for the card

  } // body

}
