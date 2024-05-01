import SwiftUI
import UniformTypeIdentifiers

struct TabSave: View {
  @State private var selectedExample: String = "Shapes"
  @State private var pictureName: String
  @State private var pictureDescription: String
  @State private var author: String
  @State private var imageWidth: Int
  @State private var imageHeight: Int 

  // Access the shared document instance
  var doc: ArcDrawDocument {
    OneDocManager.shared.document
  }

  let exampleOptions = ["Cursive", "Hearts", "Moons", "Petals", "Shapes", "Spirals", "YinYang"]

  init() {
    _pictureName = State(initialValue: OneDocManager.shared.document.picdef.pictureName)
    _pictureDescription = State(initialValue: OneDocManager.shared.document.picdef.pictureDescription)
    _author = State(initialValue: OneDocManager.shared.document.picdef.author)
    _imageWidth = State(initialValue: OneDocManager.shared.document.picdef.imageWidth)
    _imageHeight = State(initialValue: OneDocManager.shared.document.picdef.imageHeight )

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
                value: $imageWidth,
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
                value: $imageHeight,
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

        Section(header:
                  Text("About")
          .font(.headline)
          .fontWeight(.medium)
        ) {

          Text("Drawing Name")
          TextField("Drawing Name", text: $pictureName)
            .textFieldStyle(.roundedBorder)
            .frame(maxWidth: 100)
            .padding(.bottom, 2)
            .onChange(of: pictureName) { newValue in
              doc.picdef.pictureName = newValue
            }

          Text("Description")
          TextEditor(text: $pictureDescription)
            .textFieldStyle(.roundedBorder)
            .frame(maxWidth: .infinity, minHeight: 80)
            .padding(.bottom, 2)
            .onChange(of: pictureName) { newValue in
              doc.picdef.pictureName = newValue
            }

          Text("Author")
          TextField("Author", text: $author)
            .textFieldStyle(.roundedBorder)
            .frame(maxWidth: 150)
            .padding(.bottom, 2)
            .onChange(of: pictureName) { newValue in
              doc.picdef.pictureName = newValue
            }

        } // section

        Divider()

      }

    }

  } // body

}
