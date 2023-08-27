import SwiftUI
import UniformTypeIdentifiers

struct TabbedView: View {
  @ObservedObject var doc: ArcDrawDocument

  @State private var selectedTab = 0

  init(doc: ArcDrawDocument) {
    self.doc = doc
    }

  var body: some View {

    TabView(selection: $selectedTab) {

      TabBasics(doc: doc)
        .tabItem {
          Label("1.Basics", systemImage: "aspectratio")
        }.tag(0)

      TabArcs(doc: doc)
        .tabItem {
          Label("2.Arcs", systemImage: "paintbrush")
        }.tag(1)

      TabSave(doc: doc)
        .tabItem {
          Label("3.Save", systemImage: "paintpalette")
        }.tag(2)

    } // end tabview

    .padding(2)
  } // end body

}
