import SwiftUI
import UniformTypeIdentifiers

struct TabbedView: View {
  @Binding var selectedExample: String

  @State private var selectedTab = 0

  // Access the shared document instance
  var doc: ArcDrawDocument {
    OneDocManager.shared.document
  }

  init( selectedExample: Binding<String>) {
    self._selectedExample = selectedExample
  }

  var body: some View {

    TabView(selection: $selectedTab) {

      TabCurves( selectedExample: $selectedExample)
        .tabItem {
          Label("1.Curves", systemImage: "paintbrush")
        }.tag(0)

      TabSave()
        .tabItem {
          Label("2.Save", systemImage: "aspectratio")
        }.tag(1)

    }

    .padding(2)
  }

}
