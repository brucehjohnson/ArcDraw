import SwiftUI
import UniformTypeIdentifiers

struct PanelUI: View {

  @ObservedObject var doc: ArcDrawDocument

  init(doc: ArcDrawDocument) {
    self.doc = doc
  }

  var body: some View {
      VStack {
        Text("ArcDraw Inputs")
          .font(.title)
          .padding(.top)

    Text("User inputs go here on the right in Views/PanelUI")
        Spacer()
        Text("Output will appear to the left in  Views/PanelDisplay")
        Spacer()
      }
      .frame(width: .infinity)

  }
}
