import SwiftUI
import AppKit

@available(macOS 11.0, *)
struct WelcomeMainInformationView: View {

  @EnvironmentObject var appState: AppState
  let showWelcomeScreen: Bool

  var body: some View {
    VStack(alignment: .leading, spacing: 20) {

      Text("ArcDraw: create art with orcs ... I mean, arcs!")
        .font(.title3)
        .foregroundColor(.primary)

      Text("This program allows you to create black and white drawings for printing and coloring.")
        .foregroundColor(.secondary)

      Text("Click Examples / Shapes to see an example.")
        .foregroundColor(.secondary)

      Text("Click File / New Document to start a new drawing.")
        .foregroundColor(.secondary)

      Button(action: {
        NSApp.sendAction(#selector(NSWindow.performClose(_:)), to: nil, from: nil)
        NSDocumentController.shared.newDocument("new.arcdraw")
      }) {
        Text("Click here to open default ArcDraw document and get started")
          .fontWeight(.semibold)
      }
      .buttonStyle(.bordered)
      .controlSize(.large)

      Toggle(isOn: $appState.shouldShowWelcomeWhenStartingUp) {
        Text("Show welcome screen when starting")
      }
      .onTapGesture {
        // do nothing else
      }
      .onChange(of: appState.shouldShowWelcomeWhenStartingUp) { newValue in
        UserDefaults.standard.setValue(newValue, forKey: "shouldShowWelcomeWhenStartingUp")
      }

    }
  }
}
