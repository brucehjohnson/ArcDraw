import SwiftUI
import UniformTypeIdentifiers

struct TabSave: View {
  @ObservedObject var doc: ArcDrawDocument

  init(doc: ArcDrawDocument) {
    self.doc = doc
  }

  var body: some View {
    ScrollView {
      VStack {

        Divider()

        Section(header:
                  Text("About")
          .font(.headline)
          .fontWeight(.medium)
        ) {
          Text("Drawing Name")
          TextField("Drawing Name", text: $doc.picdef.pictureName)
            .textFieldStyle(.roundedBorder)
            .frame(maxWidth: 100)
            .padding(.bottom, 2)

          // Description
          Text("Description")
          TextEditor(text: $doc.picdef.pictureDescription)
            .textFieldStyle(.roundedBorder)
            .frame(maxWidth: .infinity, minHeight: 80)
            .padding(.bottom, 2)

          Text("Author")
          TextField("Author", text: $doc.picdef.author)
            .textFieldStyle(.roundedBorder)
            .frame(maxWidth: 150)
            .padding(.bottom, 2)
            
        } // section

        Divider()

      }

    }

  } // body

}
