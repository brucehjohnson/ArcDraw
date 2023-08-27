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
            .onReceive(doc.picdef.pictureName.publisher.collect()) {
              let newName = String($0.prefix(30))
              doc.picdef.pictureName = newName
            }
          // Description
          Text("Description")
          TextEditor(text: $doc.picdef.pictureDescription)
            .textFieldStyle(.roundedBorder)
            .frame(maxWidth: .infinity, minHeight: 80)
            .padding(.bottom, 2)
            .onReceive(doc.picdef.pictureDescription.publisher.collect()) {
              let newDescription = String($0.prefix(1000))
              doc.picdef.pictureDescription = newDescription
            }
          Text("Author")
          TextField("Author", text: $doc.picdef.author)
            .textFieldStyle(.roundedBorder)
            .frame(maxWidth: 150)
            .padding(.bottom, 2)
            .onReceive(doc.picdef.author.publisher.collect()) {
              let newAuthor = String($0.prefix(50))
              doc.picdef.author = newAuthor
            }
        } // section

        Divider()

      }

    }

  } // body

}
