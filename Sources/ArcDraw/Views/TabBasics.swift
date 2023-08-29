import SwiftUI
import UniformTypeIdentifiers

struct TabBasics: View {
  @ObservedObject var doc: ArcDrawDocument
  @State private var selectedExample: String = "Shapes"

  let exampleOptions = ["Cursive", "Hearts", "Moons", "Petals", "Shapes", "Spirals", "YinYang"]

  init(doc: ArcDrawDocument) {
    self.doc = doc
    print("TabBasics after init(): \(doc.picdef.imageWidth)")
  }

  func aspectRatio() -> Double {
    let h = Double(doc.picdef.imageHeight)
    let w = Double(doc.picdef.imageWidth)
    return max(h / w, w / h)
  }

  func simulateTabKeyPress() {
    let source = CGEventSource(stateID: .hidSystemState)

    let tabDown = CGEvent(keyboardEventSource: source, virtualKey: 0x30, keyDown: true) // 0x30 is the virtual key code for TAB
    let tabUp = CGEvent(keyboardEventSource: source, virtualKey: 0x30, keyDown: false)

    tabDown?.post(tap: .cghidEventTap)
    tabUp?.post(tap: .cghidEventTap)
  }

  var body: some View {
    ScrollView {
      VStack {

        if doc.picdef.pictureName != "Name" && !doc.picdef.pictureName.isEmpty {
          Text("\(doc.picdef.pictureName)")
        }
        Divider()
        Section(header:
                  Text("Set Image Size")
          .font(.headline)
          .fontWeight(.medium)
          .padding(.bottom)
        ) {
          HStack {
            VStack {
              Text("Width, px:")
              TextField(
                "1000",
                value: $doc.picdef.imageWidth,
                formatter: ADFormatters.fmtImageWidthHeight
              )
              .textFieldStyle(.roundedBorder)
              .multilineTextAlignment(.trailing)
              .frame(maxWidth: 80)
              .help("Enter the width, in pixels, of the image.")
            }

            VStack {
              Text("Height, px:")
              TextField(
                "1000",
                value: $doc.picdef.imageHeight,
                formatter: ADFormatters.fmtImageWidthHeight
              )
              .textFieldStyle(.roundedBorder)
              .multilineTextAlignment(.trailing)
              .frame(maxWidth: 80)
              .help("Enter the height, in pixels, of the image.")
            }
            VStack {
              Text("Aspect Ratio")

              Text(String(format: "%.1f", aspectRatio()))
                .padding(1)
                .help("Calculated value of image width over image height.")
            } // end vstack

          } // end hstack
        } // end section

        Divider()

        // Dropdown for example selection
        VStack(spacing: 10) {
          Text("Want to see an example?")
          Picker("Example", selection: $selectedExample) {
            ForEach(exampleOptions, id: \.self) { example in
              Text(example).tag(example)
            }
          }
          .pickerStyle(.radioGroup)
          .focusable(true)

          // TODO: THis solution to the focus problem
          // required me to give my machine permission
          // to ArcDraw to use accessibility features
          Button("Show Example") {
            simulateTabKeyPress()
              doc.loadExampleJSONAndUpdate(selectedExample.lowercased())
            }
          .buttonStyle(DefaultButtonStyle())
          .padding()
          .focusable(true)

        }
        Spacer()

      } //  vstack
    } // scrollview
  } //  body
}
