import SwiftUI

struct DotListView: View {
  @ObservedObject var doc: ArcDrawDocument // Add this line
  @Binding var dots: [DotDefinition]

  var body: some View {

    VStack {

    // Column headings
    HStack {
      Text("#").frame(width: 20)
      Text("X").frame(width: 60)
      Text("Y").frame(width: 60)
      Button("Add New Dot") {
        if let selectedCurveIndex = doc.selectedCurveIndex,
           let selectedDotIndex = doc.selectedDotIndex {
          doc.addDotAfter(atCurveIndex: selectedCurveIndex, dotIndex: selectedDotIndex)
        }
      }
      Spacer()
    }

    List {
      ForEach(dots.indices, id: \.self) { index in
        HStack {
          TextField("", value: $dots[index].num, formatter: NumberFormatter())
            .frame(width: 20)
          TextField("", text: $dots[index].x)
            .frame(width: 60)
          TextField("", text: $dots[index].y)
            .frame(width: 60)
          Button(action: {
            dots.remove(at: index)
          }) {
            Image(systemName: "trash")
              .foregroundColor(.red)
          }
        }
      }
    }
    .frame(maxHeight: 200) // Limit the height of the list
    .overlay(
      RoundedRectangle(cornerRadius: 8)
        .stroke(Color.gray, lineWidth: 1)
    )
    .border(Color.blue)
    .padding(.vertical)

  } // VStack
    .border(Color.green)
} // body
}
