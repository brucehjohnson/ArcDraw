import SwiftUI
import AppKit

@available(macOS 12.0, *)
@main
struct ArcDrawApp: App {
  @StateObject var appState = AppState()
  @State private var shouldShowWelcomeWhenStartingUp: Bool
  @State var selectedExample: String = ""
  @State var showReadOnlyAlert: Bool = false
  @State var showAlert: Bool = false
  @State var alertMessage: String = ""


  init() {
    let initialState = UserDefaults.standard.object(forKey: "shouldShowWelcomeWhenStartingUp") as? Bool ?? true
    _appState = StateObject(wrappedValue: AppState())
    _shouldShowWelcomeWhenStartingUp = State(initialValue: initialState)
  }


  var body: some Scene {

    // Access the shared document instance
    var doc: ArcDrawDocument {
      OneDocManager.shared.document
    }

    WindowGroup {
      if shouldShowWelcomeWhenStartingUp {
        WelcomeView()
          .environmentObject(appState)
          .onAppear {
            print("Showing Welcome Screen on Startup")
            NSWindow.allowsAutomaticWindowTabbing = false
          }
      } else {
        ContentView(selectedExample: $selectedExample, showAlert: $showAlert, alertMessage: $alertMessage, showReadOnlyAlert: $showReadOnlyAlert)
          .background(WindowAccessor { window in
            if let window = window {
              let uniqueIdentifier = doc.picdef.id
              window.setFrameAutosaveName("Document Window \(uniqueIdentifier.uuidString)")
            }
          })
          .onAppear {
            NSWindow.allowsAutomaticWindowTabbing = false
            selectedExample = ""
            doc.resetDocumentState()

          }
          .onDisappear {
            print("Window closing - calling reset")
            selectedExample = ""
            doc.resetDocumentState()
          }
      }
    }

    DocumentGroup(newDocument: { () -> ArcDrawDocument in
      print("Creating new document")
      return OneDocManager.shared.document
    }) { file  in
       ConfiguredContentView(selectedExample: $selectedExample, showAlert: $showAlert, alertMessage: $alertMessage, showReadOnlyAlert: $showReadOnlyAlert)
    }



      .commands {
        appMenuCommands()
      }

    }
  }


