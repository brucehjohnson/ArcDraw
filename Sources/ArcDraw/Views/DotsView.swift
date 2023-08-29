import SwiftUI

struct DotsView: View {
  @ObservedObject var doc: ArcDrawDocument // Add this line
  @Binding var dots: [DotDefinition]

  var body: some View {
    VStack {
      List {
        ForEach(dots.indices, id: \.self) { index in
          HStack {
            Text("X: \(dots[index].x), Y: \(dots[index].y)")
            Spacer()
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
      .frame(maxHeight: 200)
      .border(Color.blue)
      .padding(.vertical)

      Button("Add New Dot") {
        if let selectedCurveIndex = doc.selectedCurveIndex,
           let selectedDotIndex = doc.selectedDotIndex {
          doc.addDotAfter(atCurveIndex: selectedCurveIndex, dotIndex: selectedDotIndex)
        }      }
    } // vstack
    .border(Color.green)
  } // body
}
