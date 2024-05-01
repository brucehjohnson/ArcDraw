import SwiftUI
import AppKit
import Foundation
import UniformTypeIdentifiers
import CoreGraphics

@available(macOS 12.0, *)
struct ConfiguredContentView: View {
  @Binding var selectedExample: String
  @Binding var showAlert: Bool
  @Binding var alertMessage: String
  @Binding var showReadOnlyAlert: Bool

  // Access the shared document instance
  var doc: ArcDrawDocument {
    OneDocManager.shared.document
  }

  var body: some View {
    //print("ConfiguredContentView body getting invoked")

    ContentView(selectedExample: $selectedExample, showAlert: $showAlert, alertMessage: $alertMessage, showReadOnlyAlert: $showReadOnlyAlert)
      .background(WindowAccessor { window in
        if let window = window {
          let uniqueIdentifier = doc.picdef.id
          window.setFrameAutosaveName("Document Window \(uniqueIdentifier.uuidString)")
        }
      })
      .onAppear {
        print("ConfiguredContentView appeared on screen")
        NSWindow.allowsAutomaticWindowTabbing = false
        selectedExample = ""
        doc.resetDocumentState()
      }
      .onDisappear {
        print("ConfiguredContentView is disappearing from screen")  
        selectedExample = ""
        doc.resetDocumentState()
      }
  }
}

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
