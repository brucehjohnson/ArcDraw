import SwiftUI
import UniformTypeIdentifiers

struct TabbedView: View {
  @ObservedObject var doc: ArcDrawDocument
  @Binding var selectedExample: String

  @State private var selectedTab = 0

  init(doc: ArcDrawDocument, selectedExample: Binding<String>) {
    self.doc = doc
    self._selectedExample = selectedExample
  }

  var body: some View {

    TabView(selection: $selectedTab) {

      TabCurves(doc: doc, selectedExample: $selectedExample)
        .tabItem {
          Label("1.Curves", systemImage: "paintbrush")
        }.tag(0)

      TabMore(doc: doc)
        .tabItem {
          Label("2.More", systemImage: "aspectratio")
        }.tag(1)

      TabSave(doc: doc)
        .tabItem {
          Label("3.Save", systemImage: "paintpalette")
        }.tag(2)

    } // end tabview

    .padding(2)
  } // end body

}
