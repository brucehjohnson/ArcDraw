import SwiftUI
import UniformTypeIdentifiers

struct TabBasics: View {
  @ObservedObject var doc: ArcDrawDocument
  @FocusState private var widthFieldFocused: Bool
  @FocusState private var heightFieldFocused: Bool

  init(doc: ArcDrawDocument) {
    self.doc = doc
    print("TabBasics after init(): \(doc.picdef.imageWidth)")
  }

  func aspectRatio() -> Double {
    let h = Double(doc.picdef.imageHeight)
    let w = Double(doc.picdef.imageWidth)
    return max(h / w, w / h)
  }

  var body: some View {
    ScrollView {
      VStack {

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
              .focused($widthFieldFocused)

            }
            .onChange(of: doc.picdef.imageWidth) { _ in
              doc.objectWillChange.send()
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
              .focused($heightFieldFocused)

            }
            .onChange(of: doc.picdef.imageWidth) { _ in
              doc.objectWillChange.send()
            }

//            VStack {
//
//              Text("Width, px:")
//              DelayedTextFieldInt(
//                placeholder: "1100",
//                value: $doc.picdef.imageWidth,
//                formatter: ADFormatters.fmtImageWidthHeight
//              )
//              .textFieldStyle(.roundedBorder)
//              .multilineTextAlignment(.trailing)
//              .frame(maxWidth: 80)
//              .help("Enter the width, in pixels, of the image.")
//            } // end vstack
//            .onChange(of: doc.picdef.imageWidth) { newValue in
//              // Manually trigger a view refresh
//              doc.objectWillChange.send()
//            }

//            VStack {
//              Text("Height, px")
//              DelayedTextFieldInt(
//                placeholder: "1000",
//                value: $doc.picdef.imageHeight,
//                formatter: ADFormatters.fmtImageWidthHeight
//              )
//              .frame(maxWidth: 80)
//              .help("Enter the height, in pixels, of the image.")
//            } // end vstack
//            .onChange(of: doc.picdef.imageHeight) { newValue in
//              // Manually trigger a view refresh
//              doc.objectWillChange.send()
//            }

            VStack {
              Text("Aspect Ratio")

              Text(String(format: "%.1f", aspectRatio()))
                .padding(1)
                .help("Calculated value of image width over image height.")
            } // end vstack

          } // end hstack
        } // end section

        Divider()

        Spacer()

      } //  vstack
    } // scrollview
    .onAppear {
      // Reset the focus states when the view appears
      widthFieldFocused = false
      heightFieldFocused = false
    }
    .onChange(of: doc.picdef) { _ in
      // Switch focus to a non-text field element to release focus
      widthFieldFocused = false
      heightFieldFocused = false
    }
  } //  body
}
