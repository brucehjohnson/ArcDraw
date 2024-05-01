import SwiftUI
import UniformTypeIdentifiers

struct CurveListView: View {
  @Binding var selectedExample: String

  // Access the shared document instance
  var doc: ArcDrawDocument {
    OneDocManager.shared.document
  }

  var body: some View {

    VStack {
      GeometryReader { geometry in
        List {
          ForEach(Array(doc.picdef.curves.indices), id: \.self) { i in
            Rectangle()
              .frame(height: 400)
              .foregroundColor(i == doc.selectedCurveIndex ? Color.primary.opacity(0.2) : Color.secondary.opacity(0.2))
              .cornerRadius(10)
         //     .overlay(
//                CurveView(selectedExample: $selectedExample, curve: doc.picdef.curves[i], isSelected: i == doc.selectedCurveIndex)

      //        )
//              .padding(2)
//              .onTapGesture {
//                doc.selectedCurveIndex = i
//              }
//              .contextMenu {
//                Button(role: .destructive) {
//                  doc.selectedCurveIndex = i
//                  doc.deleteCurve()
//                  doc.picdef.renumberCurves()
//                } label: {
//                  Label("Delete", systemImage: "trash")
//                }
//              }
          }
          .onMove { indices, curve in
            doc.picdef.curves.move(
              fromOffsets: indices,
              toOffset: curve
            )
            doc.picdef.renumberCurves()
          }
        } //list
        .frame(height: geometry.size.height)
      } // geo
      .frame(maxHeight: .infinity)
    } // vstack
    Spacer()
  } // body
}
