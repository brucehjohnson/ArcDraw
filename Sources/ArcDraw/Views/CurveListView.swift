import SwiftUI
import UniformTypeIdentifiers

struct CurveListView: View {
  @ObservedObject var doc: ArcDrawDocument
  @Binding var selectedExample: String

  init(doc: ArcDrawDocument, selectedExample: Binding<String>) {
    self.doc = doc
    self._selectedExample = selectedExample
  }

    var body: some View {

        VStack {

          // Wrap list in geometry reader to shrink as items delete
          GeometryReader { geometry in

            List {

              ForEach(Array($doc.picdef.curves.indices), id: \.self) { i in
                let curveBinding = $doc.picdef.curves[i]

                Rectangle()
                  .frame(height: 400)
                  .foregroundColor(i == doc.selectedCurveIndex ? Color.primary.opacity(0.2) : Color.secondary.opacity(0.2))
                  .cornerRadius(10)
                  .overlay(
                    CurveView(doc: doc, selectedExample: $selectedExample, curve: curveBinding, curveIndex: .constant(i))

                  )
                  .padding(EdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
                  .onTapGesture {
                    doc.selectedCurveIndex = i
                  }
                  .contextMenu {
                    Button(role: .destructive) {
                      doc.selectedCurveIndex = i
                      doc.deleteCurve()
                      doc.picdef.renumberCurves()
                    } label: {
                      Label("Delete", systemImage: "trash")
                    }
                  }
              }
              .onMove { indices, curve in
                doc.picdef.curves.move(
                  fromOffsets: indices,
                  toOffset: curve
                )
                doc.picdef.renumberCurves()
              }

            } // list
            .frame(height: geometry.size.height)

          }  // geo
          .frame(maxHeight: .infinity)
        }
       // .border(Color.black)

        Spacer()

    } // body
}
