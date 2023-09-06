import SwiftUI
import AppKit


// Access user dimensions
struct WindowAccessor: NSViewRepresentable {
  var callback: (NSWindow?) -> Void

  func makeNSView(context: Context) -> NSView {
    let view = NSView()
    DispatchQueue.main.async {
      self.callback(view.window)
    }
    return view
  }

  func updateNSView(_ nsView: NSView, context: Context) {}
}

@available(macOS 12.0, *)
@main
struct ArcDrawApp: App {

  @ObservedObject var doc: ArcDrawDocument = ArcDrawDocument()
  @StateObject var appState = AppState()
  @State private var shouldShowWelcomeWhenStartingUp: Bool
  @State var selectedExample: String = "Shapes"

  var exampleOptions = ["Cursive", "Hearts", "Moons", "Petals", "Shapes", "Spirals", "YinYang"]

  init() {

    let initialState = UserDefaults.standard.object(forKey: "shouldShowWelcomeWhenStartingUp") as? Bool ?? true
    _appState = StateObject(wrappedValue: AppState())
    _shouldShowWelcomeWhenStartingUp = State(initialValue: initialState)
    doc.selectedExample = "Shapes"

  }

  internal struct AppConstants {
    static let defaultOpeningWidth: CGFloat = 800.0
    static let defaultOpeningHeight: CGFloat = 600.0
    static let defaultPercentWidth: CGFloat = 0.8
    static let defaultPercentHeight: CGFloat = 0.8
    static let dockAndPreviewsWidth: CGFloat = 200.0
    static let minWelcomeWidth: CGFloat = 500.0
    static let minWelcomeHeight: CGFloat = 500.0
    static let heightMargin: CGFloat = 50.0

    internal static func defaultWidth() -> CGFloat {
      if let screenWidth = NSScreen.main?.visibleFrame.width {
        return min(screenWidth * defaultPercentWidth, screenWidth - dockAndPreviewsWidth)
      }
      return defaultOpeningWidth
    }

    internal static func defaultHeight() -> CGFloat {
      if let screenHeight = NSScreen.main?.visibleFrame.height {
        return screenHeight * defaultPercentHeight
      }
      return defaultOpeningHeight
    }

    internal static func maxWelcomeWidth() -> CGFloat {
      if let screenWidth = NSScreen.main?.visibleFrame.width {
        return screenWidth * 0.66
      }
      return minWelcomeWidth
    }

    internal static func maxWelcomeHeight() -> CGFloat {
      if let screenHeight = NSScreen.main?.visibleFrame.height {
        return screenHeight * 0.8
      }
      return minWelcomeHeight
    }

    internal static func maxDocumentWidth() -> CGFloat {
      if let screenWidth = NSScreen.main?.visibleFrame.width {
        return screenWidth - dockAndPreviewsWidth
      }
      return defaultOpeningWidth
    }

    internal static func maxDocumentHeight() -> CGFloat {
      if let screenHeight = NSScreen.main?.visibleFrame.height {
        return screenHeight - heightMargin
      }
      return defaultOpeningHeight
    }

  }

  var body: some Scene {

    WindowGroup {
      if shouldShowWelcomeWhenStartingUp {
        WelcomeView()
          .environmentObject(appState)
          .onAppear {
            print("Showing Welcome Screen on Startup")
            NSWindow.allowsAutomaticWindowTabbing = false
          }
      } else {
        ContentView(doc: doc, selectedExample: $selectedExample)
          .background(WindowAccessor { window in
            if let window = window {
              let uniqueIdentifier = doc.picdef.id
              window.setFrameAutosaveName("Document Window \(uniqueIdentifier.uuidString)")
            }
          })
          .onAppear {
            NSWindow.allowsAutomaticWindowTabbing = false
          }
      }
    }

    DocumentGroup(newDocument: { ArcDrawDocument() }) { file in
      let doc = file.document
      ContentView(doc: doc, selectedExample: $selectedExample)
        .background(WindowAccessor { window in
          if let window = window {
            let uniqueIdentifier = doc.picdef.id
            window.setFrameAutosaveName("Document Window \(uniqueIdentifier.uuidString)")
          }
        })
        .onAppear {
          NSWindow.allowsAutomaticWindowTabbing = false
        }
    } // Document group

    .commands {
      appMenuCommands()
    }
  }

}

